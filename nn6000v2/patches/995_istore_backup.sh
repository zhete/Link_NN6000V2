#!/bin/sh
# ============================================================
# iStore 软件备份脚本
# 在系统升级前自动备份已安装的 iStore 软件列表
# ============================================================

backup_istore_packages() {
    local backup_dir="/etc/istore"
    local backup_file="$backup_dir/installed_packages.txt"
    
    # 创建备份目录
    mkdir -p "$backup_dir"
    
    # 获取已安装的 iStore 软件列表
    if [ -x /usr/bin/is-opkg ]; then
        /usr/bin/is-opkg list-installed 2>/dev/null | awk '{print $1}' > "$backup_file"
        logger -t istore_backup "已备份 iStore 软件列表到 $backup_file"
    fi
}

# 在系统升级前执行备份
if [ "$1" = "preupgrade" ]; then
    backup_istore_packages
fi
