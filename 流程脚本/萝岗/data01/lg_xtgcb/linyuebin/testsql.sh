#!/bin/bash
# 仅用于测试：execute_hive_sql 函数是否正常工作
# 依赖：beeline 命令

# ====================== 【仅修改这里！】 ======================
HIVE_JDBC_URL="jdbc:hive2://10.169.129.141:2181,10.169.129.142:2181,10.169.129.143:2181/default;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2;principal=hive/gzhlwtz@HLWKDC"
HIVE_USER="hive"
HIVE_PASSWORD=""
# ============================================================

# 日志函数
log() {
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] $1"
}

# 核心测试函数：执行Hive SQL
execute_hive_sql() {
    local sql=$1
    log "执行SQL：$sql"
    /usr/bch/3.0.1/hive/bin/beeline -u "$HIVE_JDBC_URL" -hiveconf mapreduce.job.queuename=root.bdoc.lg_xtgcb_yarn84 \
        --silent=true --outputformat=tsv2 -e "$sql" 2>&1 | grep -vE "SLF4J|WARN|INFO"
}

# ====================== 开始测试 ======================
log "========== 开始测试 Beeline SQL 执行 =========="



# 测试2：执行简单计算SQL（验证计算能力）
log "===== 测试2：执行简单计算 SQL ====="
result2=$(execute_hive_sql "SELECT 1+1 AS test_result;")
log "测试2 结果：$result2"


log "========== 测试完成 =========="
