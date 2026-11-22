# HyperQwen Hardening Changes

This repository contains unofficial security modifications
to the original HyperQwen container image.

## Operating System

Updated available Ubuntu 24.04 packages using APT.

## Python Dependencies

Updated:
- msgpack to 1.2.3
- pyarrow to 23.0.1

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
- Final image: 98 critical/high findings
- Reduction: 91.6%

The final image retains unresolved findings and runs as root.

## Attribution

Based on HyperQwen by its original contributors.

Original project:
https://github.com/syv-ai/HyperQwen

Changes are unofficial and have not been endorsed
by the upstream maintainers.
