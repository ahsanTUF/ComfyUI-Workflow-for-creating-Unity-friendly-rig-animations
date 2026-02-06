# 🎬 HY-Motion ComfyUI Setup for 8GB VRAM GPUs

> **Text-to-Animation with FBX Export** — Optimized for RTX 3070/3060 Ti/4060 and similar 8GB cards

[![Python 3.11](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/downloads/)
[![CUDA 12.4](https://img.shields.io/badge/CUDA-12.4-green.svg)](https://developer.nvidia.com/cuda-toolkit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🚀 What This Is

A complete setup for running [HY-Motion](https://github.com/Tencent-Hunyuan/HY-Motion) (Tencent's text-to-animation model) in ComfyUI with **FBX export for Unity/Blender**.

Optimized for **8GB VRAM** GPUs using:
- **HY-Motion-1.0-Lite** motion model (~1.8GB)
- **Qwen3-8B GGUF** text encoder (~5GB quantized)
- **CPU offloading** for text encoder

---

## 📋 System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **GPU VRAM** | 8GB | 8GB+ |
| **System RAM** | 16GB | 32GB |
| **Python** | 3.11 | 3.11 (required for FBX SDK) |
| **CUDA** | 12.4+ | 12.4+ |
| **Storage** | 20GB | 30GB+ |

> ⚠️ **16GB RAM users:** Close other applications before running. The GGUF model needs ~10GB RAM when dequantizing.

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

### Step 5: Install GGUF Support
```bash
pip install gguf>=0.10.0
```

### Step 6: Download Model Weights

Download from HuggingFace and place in the correct folders:

| Model | Download | Place In | Size |
|-------|----------|----------|------|
| **HY-Motion-1.0-Lite** | [Download](https://huggingface.co/tencent/HY-Motion-1.0/tree/main/HY-Motion-1.0-Lite) | `models/HY-Motion/ckpts/tencent/HY-Motion-1.0-Lite/` | ~1.8GB |
| **Qwen3-8B GGUF** | [Download](https://huggingface.co/Qwen/Qwen3-8B-GGUF) | `models/HY-Motion/ckpts/GGUF/` | ~5GB |
| **Qwen3 Tokenizer** | [Download](https://huggingface.co/Qwen/Qwen3-8B) | `models/HY-Motion/ckpts/GGUF/` | ~15MB |

**Required files for HY-Motion-1.0-Lite:**
- `config.yml`
- `latest.ckpt`

**Required files for GGUF (in same folder):**
- `Qwen3-8B-Q4_K_M.gguf` (or Q2_K for low RAM systems)
- `tokenizer.json`
- `tokenizer_config.json`
- `vocab.json`
- `merges.txt`

### Step 7: Apply Plugin Fix (Required)

The plugin has a bug with newer `huggingface_hub` versions. Edit `custom_nodes/ComfyUI-HY-Motion1/nodes.py`:

Find and **comment out** these lines (around line 419 and 683):
```python
# "force_download": False,  # Commented: deprecated in newer huggingface_hub
# "resume_download": False  # Commented: deprecated in newer huggingface_hub
```

### Step 8: Run ComfyUI
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

### Choose Your Text Encoder Approach

| Approach | Download | RAM Needed | Best For |
|----------|----------|------------|----------|
| **GGUF (Recommended)** | ~5GB | 32GB+ | Large RAM systems |
| **Full Model + int4** | ~16GB | 16GB | Lower RAM, Windows issues with BNB |

---

### Option A: GGUF Workflow (32GB+ RAM)

Load workflow: `workflows/workflow-gguf.json`

| Node | Setting | Value |
|------|---------|-------|
| **HY-Motion Load LLM (GGUF)** | gguf_file | `Qwen3-8B-Q4_K_M.gguf` |
| **HY-Motion Load LLM (GGUF)** | device_strategy | `cpu` |
| **HY-Motion Load Network** | model_name | `HY-Motion-1.0-Lite` |

> ⚠️ GGUF dequantizes from 5GB → ~15GB during loading. Needs 32GB RAM.

---

### Option B: Full Model + int4 (16GB RAM)

Load workflow: `workflows/workflow.json` (standard)

**Download full Qwen3-8B:** [HuggingFace](https://huggingface.co/Qwen/Qwen3-8B) (~16GB)

Place in: `models/HY-Motion/ckpts/Qwen3-8B/`

| Node | Setting | Value |
|------|---------|-------|
| **HY-Motion Load LLM** | model_name | `Qwen3-8B` |
| **HY-Motion Load LLM** | quantization | `int4` |
| **HY-Motion Load LLM** | offload_to_cpu | `True` |
| **HY-Motion Load Network** | model_name | `HY-Motion-1.0-Lite` |

> ℹ️ int4 keeps model compressed (~4GB). BitsAndBytes may have Windows DLL issues.

---


## 📁 Folder Structure

```
├── README.md                 # This file
├── UNITY-WORKFLOW.md         # Animation to Unity pipeline
├── Launch-HYMotion.bat       # Windows launcher
└── ComfyUI_py311/
    ├── custom_nodes/
    │   └── ComfyUI-HY-Motion1/
    │       └── workflows/
    │           └── workflow-gguf.json  # Use this workflow!
    └── models/HY-Motion/ckpts/
        ├── tencent/
        │   └── HY-Motion-1.0-Lite/
        │       ├── config.yml
        │       └── latest.ckpt
        └── GGUF/
            ├── Qwen3-8B-Q4_K_M.gguf
            ├── tokenizer.json
            ├── tokenizer_config.json
            ├── vocab.json
            └── merges.txt
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

## 📊 Performance (RTX 3070 8GB)

| Phase | Time |
|-------|------|
| First load (GGUF dequantize) | ~2-3 min |
| Subsequent prompts | ~45-90 sec |
| Motion network only | ~30 sec |

---

## ❓ Troubleshooting

| Error | Solution |
|-------|----------|
| `resume_download` error | Apply plugin fix (Step 7) |
| `CUDA out of memory` | Set `device_strategy: cpu` |
| `Allocation on device` | Close other apps, need 10GB+ RAM free |
| `Tokenizer not found` | Download tokenizer files to GGUF folder |
| `gguf not installed` | Run `pip install gguf>=0.10.0` |
| `FBX export fails` | Verify Python 3.11 (not 3.12/3.13) |
| Yellow "Error loading model" | Restart ComfyUI after downloading models |

---

## 🔗 Credits

- [HY-Motion](https://github.com/Tencent-Hunyuan/HY-Motion) by Tencent Hunyuan Team
- [ComfyUI-HY-Motion1](https://github.com/jtydhr88/ComfyUI-HY-Motion1) by jtydhr88
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)

---

## 📄 License

MIT License - See [LICENSE](LICENSE)
