# Relatório de Vulnerabilidades - Trivy

### Alvo: giropops-senhas:3.0 (alpine 3.18.3)

| Pacote | ID (CVE) | Severidade | Versão Instalada | Correção em | Título |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `busybox` | [CVE-2023-42363](https://avd.aquasec.com/nvd/cve-2023-42363) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free in awk |
| `busybox` | [CVE-2023-42364](https://avd.aquasec.com/nvd/cve-2023-42364) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free |
| `busybox` | [CVE-2023-42365](https://avd.aquasec.com/nvd/cve-2023-42365) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free |
| `busybox` | [CVE-2023-42366](https://avd.aquasec.com/nvd/cve-2023-42366) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r6 | busybox: A heap-buffer-overflow |
| `busybox-binsh` | [CVE-2023-42363](https://avd.aquasec.com/nvd/cve-2023-42363) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free in awk |
| `busybox-binsh` | [CVE-2023-42364](https://avd.aquasec.com/nvd/cve-2023-42364) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free |
| `busybox-binsh` | [CVE-2023-42365](https://avd.aquasec.com/nvd/cve-2023-42365) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free |
| `busybox-binsh` | [CVE-2023-42366](https://avd.aquasec.com/nvd/cve-2023-42366) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r6 | busybox: A heap-buffer-overflow |
| `krb5-libs` | [CVE-2024-37371](https://avd.aquasec.com/nvd/cve-2024-37371) | **CRITICAL** | 1.20.1-r1 | 1.20.2-r1 | krb5: GSS message token handling |
| `krb5-libs` | [CVE-2024-37370](https://avd.aquasec.com/nvd/cve-2024-37370) | **HIGH** | 1.20.1-r1 | 1.20.2-r1 | krb5: GSS message token handling |
| `krb5-libs` | [CVE-2023-36054](https://avd.aquasec.com/nvd/cve-2023-36054) | **MEDIUM** | 1.20.1-r1 | 1.20.2-r0 | krb5: Denial of service through freeing uninitialized pointer |
| `libcrypto3` | [CVE-2023-5363](https://avd.aquasec.com/nvd/cve-2023-5363) | **HIGH** | 3.1.2-r0 | 3.1.4-r0 | openssl: Incorrect cipher key and IV length processing |
| `libcrypto3` | [CVE-2024-6119](https://avd.aquasec.com/nvd/cve-2024-6119) | **HIGH** | 3.1.2-r0 | 3.1.7-r0 | openssl: Possible denial of service in X.509 name checks |
| `libcrypto3` | [CVE-2023-5678](https://avd.aquasec.com/nvd/cve-2023-5678) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r1 | openssl: Generating excessively long X9.42 DH keys or checking excessively long X9.42 DH keys or parameters may be very slow |
| `libcrypto3` | [CVE-2023-6129](https://avd.aquasec.com/nvd/cve-2023-6129) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r3 | openssl: POLY1305 MAC implementation corrupts vector registers on PowerPC |
| `libcrypto3` | [CVE-2023-6237](https://avd.aquasec.com/nvd/cve-2023-6237) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r4 | openssl: Excessive time spent checking invalid RSA public keys |
| `libcrypto3` | [CVE-2024-0727](https://avd.aquasec.com/nvd/cve-2024-0727) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r5 | openssl: denial of service via null dereference |
| `libcrypto3` | [CVE-2024-13176](https://avd.aquasec.com/nvd/cve-2024-13176) | **MEDIUM** | 3.1.2-r0 | 3.1.8-r0 | openssl: Timing side-channel in ECDSA signature computation |
| `libcrypto3` | [CVE-2024-4603](https://avd.aquasec.com/nvd/cve-2024-4603) | **MEDIUM** | 3.1.2-r0 | 3.1.5-r0 | openssl: Excessive time spent checking DSA keys and parameters |
| `libcrypto3` | [CVE-2024-4741](https://avd.aquasec.com/nvd/cve-2024-4741) | **MEDIUM** | 3.1.2-r0 | 3.1.6-r0 | openssl: Use After Free with SSL_free_buffers |
| `libcrypto3` | [CVE-2024-5535](https://avd.aquasec.com/nvd/cve-2024-5535) | **MEDIUM** | 3.1.2-r0 | 3.1.6-r0 | openssl: SSL_select_next_proto buffer overread |
| `libcrypto3` | [CVE-2024-2511](https://avd.aquasec.com/nvd/cve-2024-2511) | **LOW** | 3.1.2-r0 | 3.1.4-r6 | openssl: Unbounded memory growth with session handling in TLSv1.3 |
| `libcrypto3` | [CVE-2024-9143](https://avd.aquasec.com/nvd/cve-2024-9143) | **LOW** | 3.1.2-r0 | 3.1.7-r1 | openssl: Low-level invalid GF(2^m) parameters lead to OOB memory access |
| `libexpat` | [CVE-2024-45491](https://avd.aquasec.com/nvd/cve-2024-45491) | **CRITICAL** | 2.5.0-r1 | 2.6.3-r0 | libexpat: Integer Overflow or Wraparound |
| `libexpat` | [CVE-2024-45492](https://avd.aquasec.com/nvd/cve-2024-45492) | **CRITICAL** | 2.5.0-r1 | 2.6.3-r0 | libexpat: integer overflow |
| `libexpat` | [CVE-2023-52425](https://avd.aquasec.com/nvd/cve-2023-52425) | **HIGH** | 2.5.0-r1 | 2.6.0-r0 | expat: parsing large tokens can trigger a denial of service |
| `libexpat` | [CVE-2024-28757](https://avd.aquasec.com/nvd/cve-2024-28757) | **HIGH** | 2.5.0-r1 | 2.6.2-r0 | expat: XML Entity Expansion |
| `libexpat` | [CVE-2024-45490](https://avd.aquasec.com/nvd/cve-2024-45490) | **HIGH** | 2.5.0-r1 | 2.6.3-r0 | libexpat: Negative Length Parsing Vulnerability in libexpat |
| `libexpat` | [CVE-2024-8176](https://avd.aquasec.com/nvd/cve-2024-8176) | **HIGH** | 2.5.0-r1 | 2.7.0-r0 | libexpat: expat: Improper Restriction of XML Entity Expansion Depth in libexpat |
| `libexpat` | [CVE-2023-52426](https://avd.aquasec.com/nvd/cve-2023-52426) | **MEDIUM** | 2.5.0-r1 | 2.6.0-r0 | expat: recursive XML entity expansion vulnerability |
| `libexpat` | [CVE-2024-50602](https://avd.aquasec.com/nvd/cve-2024-50602) | **MEDIUM** | 2.5.0-r1 | 2.6.4-r0 | libexpat: expat: DoS via XML_ResumeParser |
| `libssl3` | [CVE-2023-5363](https://avd.aquasec.com/nvd/cve-2023-5363) | **HIGH** | 3.1.2-r0 | 3.1.4-r0 | openssl: Incorrect cipher key and IV length processing |
| `libssl3` | [CVE-2024-6119](https://avd.aquasec.com/nvd/cve-2024-6119) | **HIGH** | 3.1.2-r0 | 3.1.7-r0 | openssl: Possible denial of service in X.509 name checks |
| `libssl3` | [CVE-2023-5678](https://avd.aquasec.com/nvd/cve-2023-5678) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r1 | openssl: Generating excessively long X9.42 DH keys or checking excessively long X9.42 DH keys or parameters may be very slow |
| `libssl3` | [CVE-2023-6129](https://avd.aquasec.com/nvd/cve-2023-6129) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r3 | openssl: POLY1305 MAC implementation corrupts vector registers on PowerPC |
| `libssl3` | [CVE-2023-6237](https://avd.aquasec.com/nvd/cve-2023-6237) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r4 | openssl: Excessive time spent checking invalid RSA public keys |
| `libssl3` | [CVE-2024-0727](https://avd.aquasec.com/nvd/cve-2024-0727) | **MEDIUM** | 3.1.2-r0 | 3.1.4-r5 | openssl: denial of service via null dereference |
| `libssl3` | [CVE-2024-13176](https://avd.aquasec.com/nvd/cve-2024-13176) | **MEDIUM** | 3.1.2-r0 | 3.1.8-r0 | openssl: Timing side-channel in ECDSA signature computation |
| `libssl3` | [CVE-2024-4603](https://avd.aquasec.com/nvd/cve-2024-4603) | **MEDIUM** | 3.1.2-r0 | 3.1.5-r0 | openssl: Excessive time spent checking DSA keys and parameters |
| `libssl3` | [CVE-2024-4741](https://avd.aquasec.com/nvd/cve-2024-4741) | **MEDIUM** | 3.1.2-r0 | 3.1.6-r0 | openssl: Use After Free with SSL_free_buffers |
| `libssl3` | [CVE-2024-5535](https://avd.aquasec.com/nvd/cve-2024-5535) | **MEDIUM** | 3.1.2-r0 | 3.1.6-r0 | openssl: SSL_select_next_proto buffer overread |
| `libssl3` | [CVE-2024-2511](https://avd.aquasec.com/nvd/cve-2024-2511) | **LOW** | 3.1.2-r0 | 3.1.4-r6 | openssl: Unbounded memory growth with session handling in TLSv1.3 |
| `libssl3` | [CVE-2024-9143](https://avd.aquasec.com/nvd/cve-2024-9143) | **LOW** | 3.1.2-r0 | 3.1.7-r1 | openssl: Low-level invalid GF(2^m) parameters lead to OOB memory access |
| `musl` | [CVE-2025-26519](https://avd.aquasec.com/nvd/cve-2025-26519) | **HIGH** | 1.2.4-r1 | 1.2.4-r3 | musl libc 0.9.13 through 1.2.5 before 1.2.6 has an out-of-bounds write ... |
| `musl-utils` | [CVE-2025-26519](https://avd.aquasec.com/nvd/cve-2025-26519) | **HIGH** | 1.2.4-r1 | 1.2.4-r3 | musl libc 0.9.13 through 1.2.5 before 1.2.6 has an out-of-bounds write ... |
| `sqlite-libs` | [CVE-2023-7104](https://avd.aquasec.com/nvd/cve-2023-7104) | **HIGH** | 3.41.2-r2 | 3.41.2-r3 | sqlite: heap-buffer-overflow at sessionfuzz |
| `ssl_client` | [CVE-2023-42363](https://avd.aquasec.com/nvd/cve-2023-42363) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free in awk |
| `ssl_client` | [CVE-2023-42364](https://avd.aquasec.com/nvd/cve-2023-42364) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free |
| `ssl_client` | [CVE-2023-42365](https://avd.aquasec.com/nvd/cve-2023-42365) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r7 | busybox: use-after-free |
| `ssl_client` | [CVE-2023-42366](https://avd.aquasec.com/nvd/cve-2023-42366) | **MEDIUM** | 1.36.1-r2 | 1.36.1-r6 | busybox: A heap-buffer-overflow |
| `xz-libs` | [CVE-2025-31115](https://avd.aquasec.com/nvd/cve-2025-31115) | **HIGH** | 5.4.3-r0 | 5.4.3-r1 | xz: XZ has a heap-use-after-free bug in threaded .xz decoder |

### Alvo: Python

| Pacote | ID (CVE) | Severidade | Versão Instalada | Correção em | Título |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `pip` | [CVE-2023-5752](https://avd.aquasec.com/nvd/cve-2023-5752) | **MEDIUM** | 23.1.2 | 23.3 | pip: Mercurial configuration injectable in repo revision when installing via pip |
| `pip` | [CVE-2025-8869](https://avd.aquasec.com/nvd/cve-2025-8869) | **MEDIUM** | 23.1.2 | 25.3 | pip: pip missing checks on symbolic link extraction |
| `setuptools` | [CVE-2024-6345](https://avd.aquasec.com/nvd/cve-2024-6345) | **HIGH** | 65.5.1 | 70.0.0 | pypa/setuptools: Remote code execution via download functions in the package_index module in pypa/setuptools |
| `setuptools` | [CVE-2025-47273](https://avd.aquasec.com/nvd/cve-2025-47273) | **HIGH** | 65.5.1 | 78.1.1 | setuptools: Path Traversal Vulnerability in setuptools PackageIndex |
| `wheel` | [CVE-2026-24049](https://avd.aquasec.com/nvd/cve-2026-24049) | **HIGH** | 0.41.1 | 0.46.2 | wheel: wheel: Privilege Escalation or Arbitrary Code Execution via malicious wheel file unpacking |