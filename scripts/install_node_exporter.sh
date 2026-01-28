#!/bin/bash
# Node Exporter 安裝腳本
# 用法: curl -sSL <url> | sudo bash

set -e

VERSION="1.8.2"
ARCH="linux-amd64"
DOWNLOAD_URL="https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.${ARCH}.tar.gz"

echo "=== 安裝 Node Exporter v${VERSION} ==="

# 下載並解壓
cd /tmp
wget -q "${DOWNLOAD_URL}" -O node_exporter.tar.gz
tar xzf node_exporter.tar.gz
sudo mv "node_exporter-${VERSION}.${ARCH}/node_exporter" /usr/local/bin/
rm -rf node_exporter.tar.gz "node_exporter-${VERSION}.${ARCH}"

# 建立 systemd service
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

# 啟動服務
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# 檢查狀態
echo ""
echo "=== 安裝完成 ==="
echo "狀態: $(systemctl is-active node_exporter)"
echo "測試: curl -s http://localhost:9100/metrics | head -5"
echo ""
curl -s http://localhost:9100/metrics | head -5
