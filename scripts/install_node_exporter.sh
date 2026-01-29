#!/bin/bash
# Node Exporter 跨平台安裝腳本
# 支援: Linux (amd64/arm64), macOS (Intel/Apple Silicon)
# 用法: curl -sSL <url> | sudo bash

set -e

VERSION="1.8.2"
BASE_URL="https://github.com/prometheus/node_exporter/releases/download/v${VERSION}"

# 偵測作業系統和架構
detect_platform() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)
    
    case "$OS" in
        linux)
            OS_TYPE="linux"
            ;;
        darwin)
            OS_TYPE="darwin"
            ;;
        *)
            echo "錯誤: 不支援的作業系統 $OS"
            exit 1
            ;;
    esac
    
    case "$ARCH" in
        x86_64|amd64)
            ARCH_TYPE="amd64"
            ;;
        aarch64|arm64)
            ARCH_TYPE="arm64"
            ;;
        armv7l)
            ARCH_TYPE="armv7"
            ;;
        *)
            echo "錯誤: 不支援的架構 $ARCH"
            exit 1
            ;;
    esac
    
    PLATFORM="${OS_TYPE}-${ARCH_TYPE}"
    echo "偵測到平台: $PLATFORM"
}

# 下載並安裝
install_node_exporter() {
    DOWNLOAD_URL="${BASE_URL}/node_exporter-${VERSION}.${PLATFORM}.tar.gz"
    
    echo "=== 安裝 Node Exporter v${VERSION} (${PLATFORM}) ==="
    
    # 下載
    cd /tmp
    echo "下載中: $DOWNLOAD_URL"
    
    if command -v wget > /dev/null; then
        wget -q --show-progress "${DOWNLOAD_URL}" -O node_exporter.tar.gz
    elif command -v curl > /dev/null; then
        curl -L -# "${DOWNLOAD_URL}" -o node_exporter.tar.gz
    else
        echo "錯誤: 需要 wget 或 curl"
        exit 1
    fi
    
    # 解壓並安裝
    tar xzf node_exporter.tar.gz
    sudo mv "node_exporter-${VERSION}.${PLATFORM}/node_exporter" /usr/local/bin/
    sudo chmod +x /usr/local/bin/node_exporter
    rm -rf node_exporter.tar.gz "node_exporter-${VERSION}.${PLATFORM}"
    
    echo "✓ 二進位檔案已安裝至 /usr/local/bin/node_exporter"
}

# 設定 systemd (Linux)
setup_systemd() {
    echo "設定 systemd 服務..."
    
    sudo tee /etc/systemd/system/node_exporter.service > /dev/null << 'EOF'
[Unit]
Description=Node Exporter
Documentation=https://prometheus.io/docs/guides/node-exporter/
After=network-online.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/node_exporter
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
    
    sudo systemctl daemon-reload
    sudo systemctl enable node_exporter
    sudo systemctl start node_exporter
    
    echo "✓ systemd 服務已啟動"
}

# 設定 launchd (macOS)
setup_launchd() {
    echo "設定 launchd 服務..."
    
    sudo tee /Library/LaunchDaemons/io.prometheus.node_exporter.plist > /dev/null << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>io.prometheus.node_exporter</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/node_exporter</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/var/log/node_exporter.log</string>
    <key>StandardErrorPath</key>
    <string>/var/log/node_exporter.err</string>
</dict>
</plist>
EOF
    
    sudo launchctl load /Library/LaunchDaemons/io.prometheus.node_exporter.plist
    
    echo "✓ launchd 服務已啟動"
}

# 檢查服務狀態
check_status() {
    echo ""
    echo "=== 安裝完成 ==="
    
    if [ "$OS_TYPE" = "linux" ]; then
        echo "狀態: $(systemctl is-active node_exporter 2>/dev/null || echo 'unknown')"
        echo "查看日誌: sudo journalctl -u node_exporter -f"
    else
        echo "狀態: $(sudo launchctl list | grep node_exporter > /dev/null && echo 'active' || echo 'inactive')"
        echo "查看日誌: tail -f /var/log/node_exporter.log"
    fi
    
    echo ""
    echo "等待服務啟動..."
    sleep 3
    
    echo "測試連接:"
    if curl -s http://localhost:9100/metrics | head -5; then
        echo ""
        echo "✓ Node Exporter 運行正常!"
        echo "  存取位址: http://localhost:9100/metrics"
    else
        echo "⚠ 無法連接到 Node Exporter,請檢查服務狀態"
    fi
}

# 主程式
main() {
    detect_platform
    install_node_exporter
    
    if [ "$OS_TYPE" = "linux" ]; then
        setup_systemd
    elif [ "$OS_TYPE" = "darwin" ]; then
        setup_launchd
    fi
    
    check_status
}

main
