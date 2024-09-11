.global _print
.align 4

// ref: https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
// 4	AUE_NULL	ALL	{ user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); }

_print:
    // システムコール番号を x16 に設定 (write = #0x2000004)
    mov x16, #4

    // print 関数の第 2 引数をシステムコールの第 3 引数（文字列のバイト数）に設定
    mov x2, x1

    // print 関数の第 1 引数をシステムコールの第 2 引数（文字列の先頭アドレス）に設定
    mov x1, x0

    // システムコールの第 1 引数 (ファイルディスクリプタ) を x0 に設定 (stdout = 1)
    mov x0, #1

    // システムコール実行
    svc #0x80

    // 戻り値は x0 に入っているので、そのまま返す
    ret
