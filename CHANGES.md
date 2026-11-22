# HyperQwen Hardening Changes

This repository contains unofficial security modifications
to the original HyperQwen container image.

## Operating System

Updated available Ubuntu 24.04 packages using APT.

## Python Dependencies

Updated:
- msgpack to 1.2.3
- pyarrow to 23.0.1
- pip to 26.3, updating its bundled certifi, msgpack, and urllib3

Verified installed versions:
- certifi 2026.10.23
- urllib3 2.8.0
- setuptools 80.10.2

## Model Supply Chain

Pinned three Hugging Face model downloads to specific
repository revisions.

Disabled the unapproved BF16 DFlash2 download path.

## Security Assessment

Trivy 0.76.2 reported:

- Original image: 1,161 critical/high findings
- Previous hardened image: 98 critical/high findings
- Runtime-hardened image: 93 critical/high findings
- Reduction: approximately 92%

The remaining findings consist of:
- 92 associated with linux-libc-dev (3 critical, 89 high).
- 1 associated with setuptools 70.3.0 in pip's embedded SBOM.

The active setuptools installation is version 80.10.2.
The older SBOM entry remains under investigation.

Removing linux-libc-dev would also remove CUDA compiler
components, so that removal has not been performed.

The final image retains unresolved findings and runs as root.
Full runtime and inference compatibility testing remains outstanding.

## Attribution

Based on HyperQwen by its original contributors.

Original project:
https://github.com/syv-ai/HyperQwen

Changes are unofficial and have not been endorsed
by the upstream maintainers.
