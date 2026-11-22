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
- Updated pip to 26.3, including its bundled dependencies.
- Pinned three Hugging Face model download revisions.
- Disabled the unapproved BF16 DFlash2 download path.

## Trivy Vulnerability Results

Scanner: Trivy 0.76.2

| Build | Critical | High | Total |
|---|---:|---:|---:|
| Original | 65 | 1096 | 1161 |
| OS patched | 4 | 95 | 99 |
| Python patched | 4 | 94 | 98 |
| Pinned hardened | 4 | 94 | 98 |
| Runtime hardened (pip 26.3) | 3 | 90 | 93 |

Reduction in reported critical/high findings: approximately 92%.

These are scanner findings, not necessarily distinct
exploitable vulnerabilities.

## Build Instructions

Run these commands from the repository directory,
in the following order:

1. docker build -f Dockerfile -t hyperqwen-hardened:os-patched .
2. docker build -f Dockerfile.python -t hyperqwen-hardened:python-patched .
3. docker build -f Dockerfile.pinned -t hyperqwen-hardened:pinned .
4. docker build -f Dockerfile.runtime -t hyperqwen-hardened:runtime .

## Remaining Vulnerability Findings

The runtime-hardened image has 93 reported critical/high
findings in Trivy 0.76.2:

- 92 associated with Ubuntu's linux-libc-dev package
  (3 critical, 89 high).
- 1 associated with setuptools 70.3.0 in pip's embedded SBOM.

Trivy did not identify fixed package versions for the
linux-libc-dev findings in this scan.

An APT removal simulation showed that removing linux-libc-dev
would also remove CUDA compiler and development components.
That removal has not been performed.

The active setuptools installation is version 80.10.2.
No pip/_vendor/setuptools directory was found, although pip's
embedded SBOM still lists setuptools 70.3.0 as a dependency.
This finding may reflect an SBOM inventory discrepancy; it
has not been formally classified as a false positive.

A lower vulnerability count does not by itself establish
that an image is secure.

## Deployment Security

This repository provides a hardened HyperQwen image build,
not a preconfigured production deployment.

HyperQwen includes a vLLM API server. Users are responsible
for configuring and securing their own API deployment.

### API Authentication

Configure a unique API key before exposing the service.

For example, generate a key locally:

    openssl rand -hex 32

Pass the key to the container using the VLLM_API_KEY
environment variable or a protected environment file.

Do not commit API keys, environment files containing secrets,
or other credentials to Git.

### Network Exposure

Avoid exposing the inference API directly to the public
internet.

For local access, bind the published Docker port to
127.0.0.1 rather than 0.0.0.0.

For remote access, use a properly secured VPN or an
authenticated reverse proxy with TLS and appropriate
network access controls.

API authentication and localhost binding provide different
layers of protection. Using both is recommended.

### GPU and Model Storage

Users must provide their own compatible NVIDIA GPU,
model storage, and any required model downloads.

Persist model and cache data outside the container.
Protect these directories from unauthorized modification.

Model preparation may download external artifacts.
Review and verify external model sources before use.

### Runtime Privileges

The current image runs as root.

Use appropriate Docker isolation and avoid unnecessary
privileged mode, host networking, or sensitive host mounts.

Do not mount the Docker socket into the inference container.

### Security Responsibility

Each deployment requires its own authentication,
network configuration, patch management, and monitoring.

A successful vulnerability scan does not guarantee
that a deployment is secure.

## Limitations

- The image currently runs as root.
- 93 critical/high findings remain: 92 associated with linux-libc-dev and one with setuptools in pip's embedded SBOM.
- APT package versions are not locked to a dated snapshot.
- Python dependencies are not hash-locked.
- Model revisions are pinned but artifacts are not attested.
- Full runtime, inference, and penetration testing remain outstanding.
- Builds and vulnerability scans do not establish that the image
  is free of malicious code or exploitable flaws.

## Attribution

This is not an official HyperQwen release.
Original project and third-party license requirements apply.
