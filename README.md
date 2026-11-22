# HyperQwen — Security-Hardened Build

An unofficial security-hardened build of HyperQwen.

## Original Project
https://github.com/syv-ai/HyperQwen

Base image:
ghcr.io/syv-ai/hyperqwen@sha256:d45c405319543d5691c43cfafadd7999d4e2d47f059e0c9227f22ef4ad39a607

## Security Improvements

- Updated Ubuntu 24.04 operating-system packages.
- Updated msgpack to 1.2.3 and pyarrow to 23.0.1.
- Verified updated certifi, urllib3, and setuptools.
- Pinned three Hugging Face model download revisions.
- Disabled the unapproved BF16 DFlash2 download path.

## Trivy Vulnerability Results

Scanner: Trivy 0.76.2

| Build | Critical | High | Total |
|---|---:|---:|---:|
| Original | 65 | 1096 | 1161 |
| OS patched | 4 | 95 | 99 |
| Python patched | 4 | 94 | 98 |
| Final hardened | 4 | 94 | 98 |

Reduction in reported critical/high findings: 91.6%.

These are scanner findings, not necessarily distinct
exploitable vulnerabilities.

## Build Instructions

Run these commands from the repository directory,
in the following order:

1. docker build -f Dockerfile -t hyperqwen-hardened:os-patched .
2. docker build -f Dockerfile.python -t hyperqwen-hardened:python-patched .
3. docker build -f Dockerfile.pinned -t hyperqwen-hardened:pinned .

## Limitations

- The image currently runs as root.
- 98 critical/high findings remain.
- APT package versions are not locked to a dated snapshot.
- Python dependencies are not hash-locked.
- Model revisions are pinned but artifacts are not attested.
- Full functionality and penetration testing remain outstanding.

## Attribution

This is not an official HyperQwen release.
Original project and third-party license requirements apply.
