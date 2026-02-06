# 🎬 HY-Motion ComfyUI Setup for 8GB VRAM GPUs

> **Text-to-Animation with FBX Export** — Optimized for RTX 3070/3060 Ti/4060 and similar 8GB cards

[![Python 3.11](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/downloads/)
[![CUDA 12.4](https://img.shields.io/badge/CUDA-12.4-green.svg)](https://developer.nvidia.com/cuda-toolkit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🚀 What This Is

A complete, pre-configured setup for running [HY-Motion](https://github.com/Tencent-Hunyuan/HY-Motion) (Tencent's text-to-animation model) in ComfyUI with **FBX export for Unity/Blender**.

Optimized for **8GB VRAM** GPUs using:
- **HY-Motion-1.0-Lite** (~4GB VRAM)
- **int4 quantization** for text encoder (~4GB VRAM)

---

## 📋 Prerequisites

| Requirement | Version | Why |
|-------------|---------|-----|
| **Miniconda** | Latest | Python environment isolation |
| **Python** | 3.11 | FBX SDK requires Python 3.11 (not 3.12+) |
| **CUDA** | 12.4+ | GPU acceleration |
| **GPU VRAM** | 8GB+ | Tested on RTX 3070 |
| **Git** | Latest | Clone repositories |

---

## ⚡ Quick Start

### 1. Clone This Repository
```bash
git clone https://github.com/YOUR_USERNAME/HY-Motion-8GB-Setup.git
cd HY-Motion-8GB-Setup
```

### 2. Create Conda Environment
```bash
conda create -n comfy311 python=3.11 -y
conda activate comfy311
```

### 3. Clone ComfyUI (if not included)
```bash
git clone https://github.com/comfyanonymous/ComfyUI.git ComfyUI_py311
cd ComfyUI_py311
```

### 4. Install PyTorch with CUDA
```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
pip install -r requirements.txt
```

### 5. Install HY-Motion Plugin
```bash
cd custom_nodes
git clone https://github.com/jtydhr88/ComfyUI-HY-Motion1
cd ComfyUI-HY-Motion1
pip install -r requirements.txt
```

### 6. Download Model Weights (Manual Step)

Download from HuggingFace and place in the correct folder:

| Model | Download Link | Place In |
|-------|---------------|----------|
| **HY-Motion-1.0-Lite** | [Download](https://huggingface.co/tencent/HY-Motion-1.0-Lite) | `models/HY-Motion/ckpts/tencent/HY-Motion-1.0-Lite/` |

Required files:
- `config.yml` (~1KB)
- `latest.ckpt` (~1.8GB)

### 7. Run ComfyUI
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

## ⚙️ 8GB VRAM Configuration

In ComfyUI, use these settings:

| Node | Setting | Value |
|------|---------|-------|
| **HYMotion Load LLM** | quantization | `int4` |
| **HYMotion Load LLM** | offload_to_cpu | `True` |
| **HYMotion Load Network** | model_name | `HY-Motion-1.0-Lite` |

---

## 📁 Folder Structure

```
HY-Motion-8GB-Setup/
├── README.md                    # This file
├── Launch-HYMotion.bat          # Windows launcher
├── HY-Motion-Setup-Guide.md     # Detailed setup instructions
├── SETUP-VERIFICATION.md        # Verification checklist
├── Animation-Pipeline-Guide.md  # Unity animation workflow
└── ComfyUI_py311/               # ComfyUI installation
    ├── custom_nodes/
    │   └── ComfyUI-HY-Motion1/  # HY-Motion plugin
    └── models/
        └── HY-Motion/
            └── ckpts/
                └── tencent/
                    └── HY-Motion-1.0-Lite/  # ← Put model here
                        ├── config.yml
                        └── latest.ckpt      # ~1.8GB (not in repo)
```

---

## 🎮 Example Prompts

```
A person walking forward confidently
A person sprinting at full speed, arms pumping
A person doing a combat roll
A person jumping with arms raised
A person waving hello
```

---

## 📊 Performance

| GPU | Model | Text Encoder | Animation Time |
|-----|-------|--------------|----------------|
| RTX 3070 8GB | Lite | int4 | ~45-60s for 4s animation |
| RTX 3060 Ti 8GB | Lite | int4 | ~50-70s for 4s animation |
| RTX 4060 8GB | Lite | int4 | ~35-50s for 4s animation |

---

## 🔗 Credits & Resources

- [HY-Motion](https://github.com/Tencent-Hunyuan/HY-Motion) by Tencent Hunyuan Team
- [ComfyUI-HY-Motion1](https://github.com/jtydhr88/ComfyUI-HY-Motion1) plugin by jtydhr88
- [top3d.ai Guide](https://www.top3d.ai/learn/text-to-animation-hy-motion) for the original tutorial
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)

---

## 📄 License

MIT License - See [LICENSE](LICENSE) for details.

---

## ❓ Troubleshooting

| Error | Solution |
|-------|----------|
| `CUDA out of memory` | Enable `offload_to_cpu: True`, use Lite model |
| `Architecture not supported` | Run `pip install -U transformers` |
| `FBX export fails` | Verify Python 3.11 (not 3.12/3.13) |
| `Module not found` | Run `pip install -r requirements.txt` again |
