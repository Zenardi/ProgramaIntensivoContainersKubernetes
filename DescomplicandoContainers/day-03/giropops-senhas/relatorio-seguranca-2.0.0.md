# Relatório de Vulnerabilidades - Trivy

### Alvo: giropops-senhas:2.0 (debian 13.3)

| Pacote | ID (CVE) | Severidade | Versão Instalada | Correção em | Título |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `apt` | [CVE-2011-3374](https://avd.aquasec.com/nvd/cve-2011-3374) | **LOW** | 3.0.3 |  | It was found that apt-key in apt, all versions, do not correctly valid ... |
| `bash` | [TEMP-0841856-B18BAF](https://security-tracker.debian.org/tracker/TEMP-0841856-B18BAF) | **LOW** | 5.2.37-2+b7 |  | [Privilege escalation possible to other user than root] |
| `bsdutils` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 1:2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `bsdutils` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 1:2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `coreutils` | [CVE-2017-18018](https://avd.aquasec.com/nvd/cve-2017-18018) | **LOW** | 9.7-3 |  | coreutils: race condition vulnerability in chown and chgrp |
| `coreutils` | [CVE-2025-5278](https://avd.aquasec.com/nvd/cve-2025-5278) | **LOW** | 9.7-3 |  | coreutils: Heap Buffer Under-Read in GNU Coreutils sort via Key Specification |
| `libapt-pkg7.0` | [CVE-2011-3374](https://avd.aquasec.com/nvd/cve-2011-3374) | **LOW** | 3.0.3 |  | It was found that apt-key in apt, all versions, do not correctly valid ... |
| `libblkid1` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `libblkid1` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `libc-bin` | [CVE-2026-0861](https://avd.aquasec.com/nvd/cve-2026-0861) | **HIGH** | 2.41-12+deb13u1 |  | glibc: Integer overflow in memalign leads to heap corruption |
| `libc-bin` | [CVE-2025-15281](https://avd.aquasec.com/nvd/cve-2025-15281) | **MEDIUM** | 2.41-12+deb13u1 |  | glibc: wordexp with WRDE_REUSE and WRDE_APPEND may return uninitialized memory |
| `libc-bin` | [CVE-2026-0915](https://avd.aquasec.com/nvd/cve-2026-0915) | **MEDIUM** | 2.41-12+deb13u1 |  | glibc: glibc: Information disclosure via zero-valued network query |
| `libc-bin` | [CVE-2010-4756](https://avd.aquasec.com/nvd/cve-2010-4756) | **LOW** | 2.41-12+deb13u1 |  | glibc: glob implementation can cause excessive CPU and memory consumption due to crafted glob expressions |
| `libc-bin` | [CVE-2018-20796](https://avd.aquasec.com/nvd/cve-2018-20796) | **LOW** | 2.41-12+deb13u1 |  | glibc: uncontrolled recursion in function check_dst_limits_calc_pos_1 in posix/regexec.c |
| `libc-bin` | [CVE-2019-1010022](https://avd.aquasec.com/nvd/cve-2019-1010022) | **LOW** | 2.41-12+deb13u1 |  | glibc: stack guard protection bypass |
| `libc-bin` | [CVE-2019-1010023](https://avd.aquasec.com/nvd/cve-2019-1010023) | **LOW** | 2.41-12+deb13u1 |  | glibc: running ldd on malicious ELF leads to code execution because of wrong size computation |
| `libc-bin` | [CVE-2019-1010024](https://avd.aquasec.com/nvd/cve-2019-1010024) | **LOW** | 2.41-12+deb13u1 |  | glibc: ASLR bypass using cache of thread stack and heap |
| `libc-bin` | [CVE-2019-1010025](https://avd.aquasec.com/nvd/cve-2019-1010025) | **LOW** | 2.41-12+deb13u1 |  | glibc: information disclosure of heap addresses of pthread_created thread |
| `libc-bin` | [CVE-2019-9192](https://avd.aquasec.com/nvd/cve-2019-9192) | **LOW** | 2.41-12+deb13u1 |  | glibc: uncontrolled recursion in function check_dst_limits_calc_pos_1 in posix/regexec.c |
| `libc6` | [CVE-2026-0861](https://avd.aquasec.com/nvd/cve-2026-0861) | **HIGH** | 2.41-12+deb13u1 |  | glibc: Integer overflow in memalign leads to heap corruption |
| `libc6` | [CVE-2025-15281](https://avd.aquasec.com/nvd/cve-2025-15281) | **MEDIUM** | 2.41-12+deb13u1 |  | glibc: wordexp with WRDE_REUSE and WRDE_APPEND may return uninitialized memory |
| `libc6` | [CVE-2026-0915](https://avd.aquasec.com/nvd/cve-2026-0915) | **MEDIUM** | 2.41-12+deb13u1 |  | glibc: glibc: Information disclosure via zero-valued network query |
| `libc6` | [CVE-2010-4756](https://avd.aquasec.com/nvd/cve-2010-4756) | **LOW** | 2.41-12+deb13u1 |  | glibc: glob implementation can cause excessive CPU and memory consumption due to crafted glob expressions |
| `libc6` | [CVE-2018-20796](https://avd.aquasec.com/nvd/cve-2018-20796) | **LOW** | 2.41-12+deb13u1 |  | glibc: uncontrolled recursion in function check_dst_limits_calc_pos_1 in posix/regexec.c |
| `libc6` | [CVE-2019-1010022](https://avd.aquasec.com/nvd/cve-2019-1010022) | **LOW** | 2.41-12+deb13u1 |  | glibc: stack guard protection bypass |
| `libc6` | [CVE-2019-1010023](https://avd.aquasec.com/nvd/cve-2019-1010023) | **LOW** | 2.41-12+deb13u1 |  | glibc: running ldd on malicious ELF leads to code execution because of wrong size computation |
| `libc6` | [CVE-2019-1010024](https://avd.aquasec.com/nvd/cve-2019-1010024) | **LOW** | 2.41-12+deb13u1 |  | glibc: ASLR bypass using cache of thread stack and heap |
| `libc6` | [CVE-2019-1010025](https://avd.aquasec.com/nvd/cve-2019-1010025) | **LOW** | 2.41-12+deb13u1 |  | glibc: information disclosure of heap addresses of pthread_created thread |
| `libc6` | [CVE-2019-9192](https://avd.aquasec.com/nvd/cve-2019-9192) | **LOW** | 2.41-12+deb13u1 |  | glibc: uncontrolled recursion in function check_dst_limits_calc_pos_1 in posix/regexec.c |
| `liblastlog2-2` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `liblastlog2-2` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `libmount1` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `libmount1` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `libncursesw6` | [CVE-2025-6141](https://avd.aquasec.com/nvd/cve-2025-6141) | **LOW** | 6.5+20250216-2 |  | gnu-ncurses: ncurses Stack Buffer Overflow |
| `libsmartcols1` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `libsmartcols1` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `libsqlite3-0` | [CVE-2025-7709](https://avd.aquasec.com/nvd/cve-2025-7709) | **MEDIUM** | 3.46.1-7 |  | An integer overflow exists in the  FTS5 https://sqlite.org/fts5.html e ... |
| `libsqlite3-0` | [CVE-2021-45346](https://avd.aquasec.com/nvd/cve-2021-45346) | **LOW** | 3.46.1-7 |  | sqlite: crafted SQL query allows a malicious user to obtain sensitive information |
| `libssl3t64` | [CVE-2025-15467](https://avd.aquasec.com/nvd/cve-2025-15467) | **CRITICAL** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Remote code execution or Denial of Service via oversized Initialization Vector in CMS parsing |
| `libssl3t64` | [CVE-2025-69419](https://avd.aquasec.com/nvd/cve-2025-69419) | **HIGH** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Arbitrary code execution due to out-of-bounds write in PKCS#12 processing |
| `libssl3t64` | [CVE-2025-11187](https://avd.aquasec.com/nvd/cve-2025-11187) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Arbitrary code execution or denial of service through crafted PKCS#12 file |
| `libssl3t64` | [CVE-2025-15468](https://avd.aquasec.com/nvd/cve-2025-15468) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via NULL pointer dereference in QUIC protocol handling |
| `libssl3t64` | [CVE-2025-15469](https://avd.aquasec.com/nvd/cve-2025-15469) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Data integrity bypass in `openssl dgst` command due to silent truncation |
| `libssl3t64` | [CVE-2025-66199](https://avd.aquasec.com/nvd/cve-2025-66199) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to excessive memory allocation in TLS 1.3 certificate compression |
| `libssl3t64` | [CVE-2025-68160](https://avd.aquasec.com/nvd/cve-2025-68160) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to out-of-bounds write in BIO filter |
| `libssl3t64` | [CVE-2025-69418](https://avd.aquasec.com/nvd/cve-2025-69418) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Information disclosure and data tampering via specific low-level OCB encryption/decryption calls |
| `libssl3t64` | [CVE-2025-69420](https://avd.aquasec.com/nvd/cve-2025-69420) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via malformed TimeStamp Response |
| `libssl3t64` | [CVE-2025-69421](https://avd.aquasec.com/nvd/cve-2025-69421) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via malformed PKCS#12 file processing |
| `libssl3t64` | [CVE-2026-22795](https://avd.aquasec.com/nvd/cve-2026-22795) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to type confusion in PKCS#12 file processing |
| `libssl3t64` | [CVE-2026-22796](https://avd.aquasec.com/nvd/cve-2026-22796) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via type confusion in PKCS#7 signature verification |
| `libsystemd0` | [CVE-2013-4392](https://avd.aquasec.com/nvd/cve-2013-4392) | **LOW** | 257.9-1~deb13u1 |  | systemd: TOCTOU race condition when updating file permissions and SELinux security contexts |
| `libsystemd0` | [CVE-2023-31437](https://avd.aquasec.com/nvd/cve-2023-31437) | **LOW** | 257.9-1~deb13u1 |  | An issue was discovered in systemd 253. An attacker can modify a seale ... |
| `libsystemd0` | [CVE-2023-31438](https://avd.aquasec.com/nvd/cve-2023-31438) | **LOW** | 257.9-1~deb13u1 |  | An issue was discovered in systemd 253. An attacker can truncate a sea ... |
| `libsystemd0` | [CVE-2023-31439](https://avd.aquasec.com/nvd/cve-2023-31439) | **LOW** | 257.9-1~deb13u1 |  | An issue was discovered in systemd 253. An attacker can modify the con ... |
| `libtinfo6` | [CVE-2025-6141](https://avd.aquasec.com/nvd/cve-2025-6141) | **LOW** | 6.5+20250216-2 |  | gnu-ncurses: ncurses Stack Buffer Overflow |
| `libudev1` | [CVE-2013-4392](https://avd.aquasec.com/nvd/cve-2013-4392) | **LOW** | 257.9-1~deb13u1 |  | systemd: TOCTOU race condition when updating file permissions and SELinux security contexts |
| `libudev1` | [CVE-2023-31437](https://avd.aquasec.com/nvd/cve-2023-31437) | **LOW** | 257.9-1~deb13u1 |  | An issue was discovered in systemd 253. An attacker can modify a seale ... |
| `libudev1` | [CVE-2023-31438](https://avd.aquasec.com/nvd/cve-2023-31438) | **LOW** | 257.9-1~deb13u1 |  | An issue was discovered in systemd 253. An attacker can truncate a sea ... |
| `libudev1` | [CVE-2023-31439](https://avd.aquasec.com/nvd/cve-2023-31439) | **LOW** | 257.9-1~deb13u1 |  | An issue was discovered in systemd 253. An attacker can modify the con ... |
| `libuuid1` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `libuuid1` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `login` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 1:4.16.0-2+really2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `login` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 1:4.16.0-2+really2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `login.defs` | [CVE-2007-5686](https://avd.aquasec.com/nvd/cve-2007-5686) | **LOW** | 1:4.17.4-2 |  | initscripts in rPath Linux 1 sets insecure permissions for the /var/lo ... |
| `login.defs` | [CVE-2024-56433](https://avd.aquasec.com/nvd/cve-2024-56433) | **LOW** | 1:4.17.4-2 |  | shadow-utils: Default subordinate ID configuration in /etc/login.defs could lead to compromise |
| `login.defs` | [TEMP-0628843-DBAD28](https://security-tracker.debian.org/tracker/TEMP-0628843-DBAD28) | **LOW** | 1:4.17.4-2 |  | [more related to CVE-2005-4890] |
| `mount` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `mount` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |
| `ncurses-base` | [CVE-2025-6141](https://avd.aquasec.com/nvd/cve-2025-6141) | **LOW** | 6.5+20250216-2 |  | gnu-ncurses: ncurses Stack Buffer Overflow |
| `ncurses-bin` | [CVE-2025-6141](https://avd.aquasec.com/nvd/cve-2025-6141) | **LOW** | 6.5+20250216-2 |  | gnu-ncurses: ncurses Stack Buffer Overflow |
| `openssl` | [CVE-2025-15467](https://avd.aquasec.com/nvd/cve-2025-15467) | **CRITICAL** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Remote code execution or Denial of Service via oversized Initialization Vector in CMS parsing |
| `openssl` | [CVE-2025-69419](https://avd.aquasec.com/nvd/cve-2025-69419) | **HIGH** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Arbitrary code execution due to out-of-bounds write in PKCS#12 processing |
| `openssl` | [CVE-2025-11187](https://avd.aquasec.com/nvd/cve-2025-11187) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Arbitrary code execution or denial of service through crafted PKCS#12 file |
| `openssl` | [CVE-2025-15468](https://avd.aquasec.com/nvd/cve-2025-15468) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via NULL pointer dereference in QUIC protocol handling |
| `openssl` | [CVE-2025-15469](https://avd.aquasec.com/nvd/cve-2025-15469) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Data integrity bypass in `openssl dgst` command due to silent truncation |
| `openssl` | [CVE-2025-66199](https://avd.aquasec.com/nvd/cve-2025-66199) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to excessive memory allocation in TLS 1.3 certificate compression |
| `openssl` | [CVE-2025-68160](https://avd.aquasec.com/nvd/cve-2025-68160) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to out-of-bounds write in BIO filter |
| `openssl` | [CVE-2025-69418](https://avd.aquasec.com/nvd/cve-2025-69418) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Information disclosure and data tampering via specific low-level OCB encryption/decryption calls |
| `openssl` | [CVE-2025-69420](https://avd.aquasec.com/nvd/cve-2025-69420) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via malformed TimeStamp Response |
| `openssl` | [CVE-2025-69421](https://avd.aquasec.com/nvd/cve-2025-69421) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via malformed PKCS#12 file processing |
| `openssl` | [CVE-2026-22795](https://avd.aquasec.com/nvd/cve-2026-22795) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to type confusion in PKCS#12 file processing |
| `openssl` | [CVE-2026-22796](https://avd.aquasec.com/nvd/cve-2026-22796) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via type confusion in PKCS#7 signature verification |
| `openssl-provider-legacy` | [CVE-2025-15467](https://avd.aquasec.com/nvd/cve-2025-15467) | **CRITICAL** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Remote code execution or Denial of Service via oversized Initialization Vector in CMS parsing |
| `openssl-provider-legacy` | [CVE-2025-69419](https://avd.aquasec.com/nvd/cve-2025-69419) | **HIGH** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Arbitrary code execution due to out-of-bounds write in PKCS#12 processing |
| `openssl-provider-legacy` | [CVE-2025-11187](https://avd.aquasec.com/nvd/cve-2025-11187) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Arbitrary code execution or denial of service through crafted PKCS#12 file |
| `openssl-provider-legacy` | [CVE-2025-15468](https://avd.aquasec.com/nvd/cve-2025-15468) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via NULL pointer dereference in QUIC protocol handling |
| `openssl-provider-legacy` | [CVE-2025-15469](https://avd.aquasec.com/nvd/cve-2025-15469) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Data integrity bypass in `openssl dgst` command due to silent truncation |
| `openssl-provider-legacy` | [CVE-2025-66199](https://avd.aquasec.com/nvd/cve-2025-66199) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to excessive memory allocation in TLS 1.3 certificate compression |
| `openssl-provider-legacy` | [CVE-2025-68160](https://avd.aquasec.com/nvd/cve-2025-68160) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to out-of-bounds write in BIO filter |
| `openssl-provider-legacy` | [CVE-2025-69418](https://avd.aquasec.com/nvd/cve-2025-69418) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Information disclosure and data tampering via specific low-level OCB encryption/decryption calls |
| `openssl-provider-legacy` | [CVE-2025-69420](https://avd.aquasec.com/nvd/cve-2025-69420) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via malformed TimeStamp Response |
| `openssl-provider-legacy` | [CVE-2025-69421](https://avd.aquasec.com/nvd/cve-2025-69421) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via malformed PKCS#12 file processing |
| `openssl-provider-legacy` | [CVE-2026-22795](https://avd.aquasec.com/nvd/cve-2026-22795) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service due to type confusion in PKCS#12 file processing |
| `openssl-provider-legacy` | [CVE-2026-22796](https://avd.aquasec.com/nvd/cve-2026-22796) | **MEDIUM** | 3.5.4-1~deb13u1 | 3.5.4-1~deb13u2 | openssl: OpenSSL: Denial of Service via type confusion in PKCS#7 signature verification |
| `passwd` | [CVE-2007-5686](https://avd.aquasec.com/nvd/cve-2007-5686) | **LOW** | 1:4.17.4-2 |  | initscripts in rPath Linux 1 sets insecure permissions for the /var/lo ... |
| `passwd` | [CVE-2024-56433](https://avd.aquasec.com/nvd/cve-2024-56433) | **LOW** | 1:4.17.4-2 |  | shadow-utils: Default subordinate ID configuration in /etc/login.defs could lead to compromise |
| `passwd` | [TEMP-0628843-DBAD28](https://security-tracker.debian.org/tracker/TEMP-0628843-DBAD28) | **LOW** | 1:4.17.4-2 |  | [more related to CVE-2005-4890] |
| `perl-base` | [CVE-2011-4116](https://avd.aquasec.com/nvd/cve-2011-4116) | **LOW** | 5.40.1-6 |  | perl: File:: Temp insecure temporary file handling |
| `sysvinit-utils` | [TEMP-0517018-A83CE6](https://security-tracker.debian.org/tracker/TEMP-0517018-A83CE6) | **LOW** | 3.14-4 |  | [sysvinit: no-root option in expert installer exposes locally exploitable security flaw] |
| `tar` | [CVE-2005-2541](https://avd.aquasec.com/nvd/cve-2005-2541) | **LOW** | 1.35+dfsg-3.1 |  | tar: does not properly warn the user when extracting setuid or setgid files |
| `tar` | [TEMP-0290435-0B57B5](https://security-tracker.debian.org/tracker/TEMP-0290435-0B57B5) | **LOW** | 1.35+dfsg-3.1 |  | [tar's rmt command may have undesired side effects] |
| `util-linux` | [CVE-2025-14104](https://avd.aquasec.com/nvd/cve-2025-14104) | **MEDIUM** | 2.41-5 |  | util-linux: util-linux: Heap buffer overread in setpwnam() when processing 256-byte usernames |
| `util-linux` | [CVE-2022-0563](https://avd.aquasec.com/nvd/cve-2022-0563) | **LOW** | 2.41-5 |  | util-linux: partial disclosure of arbitrary files in chfn and chsh when compiled with libreadline |

### Alvo: Python

| Pacote | ID (CVE) | Severidade | Versão Instalada | Correção em | Título |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `jaraco.context` | [CVE-2026-23949](https://avd.aquasec.com/nvd/cve-2026-23949) | **HIGH** | 5.3.0 | 6.1.0 | jaraco.context: jaraco.context: Path traversal via malicious tar archives |
| `pip` | [CVE-2025-8869](https://avd.aquasec.com/nvd/cve-2025-8869) | **MEDIUM** | 24.0 | 25.3 | pip: pip missing checks on symbolic link extraction |
| `wheel` | [CVE-2026-24049](https://avd.aquasec.com/nvd/cve-2026-24049) | **HIGH** | 0.45.1 | 0.46.2 | wheel: wheel: Privilege Escalation or Arbitrary Code Execution via malicious wheel file unpacking |
| `wheel` | [CVE-2026-24049](https://avd.aquasec.com/nvd/cve-2026-24049) | **HIGH** | 0.45.1 | 0.46.2 | wheel: wheel: Privilege Escalation or Arbitrary Code Execution via malicious wheel file unpacking |