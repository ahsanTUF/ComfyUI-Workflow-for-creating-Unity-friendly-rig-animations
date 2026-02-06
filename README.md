# 🎬 HY-Motion ComfyUI Setup for 8GB VRAM GPUs

> **Text-to-Animation with FBX Export** — Optimized for RTX 3070/3060 Ti/4060 and similar 8GB cards

[![Python 3.11](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/downloads/)
[![CUDA 12.4](https://img.shields.io/badge/CUDA-12.4-green.svg)](https://developer.nvidia.com/cuda-toolkit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🚀 What This Is

A complete setup for running [HY-Motion](https://github.com/Tencent-Hunyuan/HY-Motion) (Tencent's text-to-animation model) in ComfyUI with **FBX export for Unity/Blender**.

Optimized for **8GB VRAM** GPUs using:
- **HY-Motion-1.0-Lite** (~4GB VRAM)
- **int4 quantization** for text encoder (~4GB VRAM)

---

## 📋 Prerequisites

| Requirement | Version | Why |
|-------------|---------|-----|
| **Miniconda** | Latest | [Download](https://docs.anaconda.com/miniconda/install/) |
| **Python** | 3.11 | FBX SDK requires 3.11 (not 3.12+) |
| **CUDA** | 12.4+ | GPU acceleration |
| **GPU VRAM** | 8GB+ | Tested on RTX 3070 |
| **Git** | Latest | Clone repositories |

---

## ⚡ Installation

### Step 1: Create Conda Environment
```bash
conda create -n comfy311 python=3.11 -y
conda activate comfy311
```

### Step 2: Clone ComfyUI
```bash
git clone https://github.com/comfyanonymous/ComfyUI.git ComfyUI_py311
cd ComfyUI_py311
```

### Step 3: Install PyTorch with CUDA

> ⚠️ **Critical:** Don't skip `--index-url` or you'll get CPU-only PyTorch!

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
pip install -r requirements.txt
```

### Step 4: Install HY-Motion Plugin
```bash
cd custom_nodes
git clone https://github.com/jtydhr88/ComfyUI-HY-Motion1
cd ComfyUI-HY-Motion1
pip install -r requirements.txt
```

### Step 5: Download Model Weights

Download from HuggingFace and place in the correct folder:

| Model | Download | Place In |
|-------|----------|----------|
| **HY-Motion-1.0-Lite** | [Download](https://huggingface.co/tencent/HY-Motion-1.0/tree/main/HY-Motion-1.0-Lite) | `models/HY-Motion/ckpts/tencent/HY-Motion-1.0-Lite/` |

Required files: `config.yml` (~1KB) and `latest.ckpt` (~1.8GB)

### Step 6: Run ComfyUI
```bash
# Windows
Launch-HYMotion.bat

# Or manually
conda activate comfy311
cd ComfyUI_py311
python main.py
```

Open: **http://127.0.0.1:8188**

---

## ⚙️ 8GB VRAM Settings

| Node | Setting | Value |
|------|---------|-------|
| **HYMotion Load LLM** | quantization | `int4` |
| **HYMotion Load LLM** | offload_to_cpu | `True` |
| **HYMotion Load Network** | model_name | `HY-Motion-1.0-Lite` |

---

## 📁 Folder Structure

```
├── README.md                 # This file
├── UNITY-WORKFLOW.md         # Animation to Unity pipeline
├── Launch-HYMotion.bat       # Windows launcher
└── ComfyUI_py311/
    ├── custom_nodes/
    │   └── ComfyUI-HY-Motion1/
    └── models/HY-Motion/ckpts/tencent/
        └── HY-Motion-1.0-Lite/
            ├── config.yml
            └── latest.ckpt   # ~1.8GB (download separately)
```

---

## 🎮 Example Prompts

```
A person walking forward confidently
A person sprinting at full speed, arms pumping
A person doing a combat roll
A person jumping with arms raised
```

---

## 📊 Performance

| GPU | Model | First Run | Subsequent |
|-----|-------|-----------|------------|
| RTX 3070 8GB | Lite + int4 | ~90s | ~45-60s |
| RTX 3060 Ti 8GB | Lite + int4 | ~100s | ~50-70s |
| RTX 4060 8GB | Lite + int4 | ~70s | ~35-50s |

---

## ❓ Troubleshooting

| Error | Solution |
|-------|----------|
| `CUDA out of memory` | Set `offload_to_cpu: True`, use Lite model |
| `Architecture not supported` | `pip install -U transformers` |
| `FBX export fails` | Verify Python 3.11 (not 3.12/3.13) |
| `Module not found` | Re-run `pip install -r requirements.txt` |
| `bitsandbytes CUDA failed` | Use `int4` quantization |

---

## 🔗 Credits

- [HY-Motion](https://github.com/Tencent-Hunyuan/HY-Motion) by Tencent Hunyuan Team
- [ComfyUI-HY-Motion1](https://github.com/jtydhr88/ComfyUI-HY-Motion1) by jtydhr88
- [top3d.ai Guide](https://www.top3d.ai/learn/text-to-animation-hy-motion)
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)

---

## 📄 License

MIT License - See [LICENSE](LICENSE)
