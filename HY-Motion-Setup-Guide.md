# HY-Motion ComfyUI Setup Guide

> **Text-to-Animation with FBX Export using Python 3.11**  
> **Source:** [top3d.ai Official Guide](https://www.top3d.ai/learn/text-to-animation-hy-motion)  
> **Target Hardware:** 8GB VRAM GPUs (RTX 3070, 3060 Ti, 4060, etc.)

---

## 📋 Prerequisites

### Miniconda Installation (Required)

> [!IMPORTANT]
> HY-Motion's FBX export **only works with Python 3.11**. The latest portable ComfyUI uses Python 3.13, which breaks FBX export. Conda lets us create an isolated Python 3.11 environment.

**Download Miniconda:** https://docs.anaconda.com/miniconda/install/

After installation:
1. Open a **new** PowerShell terminal
2. Run `conda --version` to verify installation
3. If not recognized: `conda init powershell` then restart terminal

---

## 🚀 Step 1: Create Python 3.11 Environment

```bash
# Create a new environment with Python 3.11
conda create -n comfy311 python=3.11 -y

# Activate the environment
conda activate comfy311

# Verify Python version
python --version  # Should show Python 3.11.x
```

---

## 📦 Step 2: Clone and Install ComfyUI

```bash
# Navigate to your installation directory
cd "path/to/your/folder"

# Clone ComfyUI
git clone https://github.com/comfyanonymous/ComfyUI.git ComfyUI_py311
cd ComfyUI_py311
```

### Install PyTorch with CUDA Support

> [!CAUTION]
> **Do NOT skip the `--index-url` parameter!** Without it, pip installs CPU-only PyTorch.

```bash
# Upgrade pip
python -m pip install --upgrade pip

# Install PyTorch with CUDA 12.4 support (CRITICAL!)
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

# Install ComfyUI requirements
pip install -r requirements.txt
```

---

## 🔌 Step 3: Install HY-Motion Plugin

```bash
# Navigate to custom_nodes folder
cd custom_nodes

# Clone the HY-Motion plugin
git clone https://github.com/jtydhr88/ComfyUI-HY-Motion1

# Enter plugin folder and install dependencies
cd ComfyUI-HY-Motion1
pip install -r requirements.txt
```

### Verify FBX SDK

```bash
pip show fbxsdkpy
```

Should show version `2020.1.post2` or similar.

---

## 📥 Step 4: Download Model Weights

### Required: HY-Motion-1.0-Lite

Download from: **https://huggingface.co/tencent/HY-Motion-1.0-Lite**

Place files in:
```
ComfyUI_py311/models/HY-Motion/ckpts/tencent/HY-Motion-1.0-Lite/
├── config.yml    (~1KB)
└── latest.ckpt   (~1.8GB)
```

### Text Encoder (Built-in)

For 8GB VRAM, use **int4 quantization** which is built into transformers — no extra download required!

---

## ▶️ Step 5: Run ComfyUI

### Windows
```cmd
Launch-HYMotion.bat
```

### Manual Launch
```bash
conda activate comfy311
cd ComfyUI_py311
python main.py
```

Open your browser: **http://127.0.0.1:8188**

Load workflows from: `custom_nodes/ComfyUI-HY-Motion1/workflow/`

---

## ⚙️ Optimal Settings for 8GB VRAM

| Node | Setting | Value |
|------|---------|-------|
| **HYMotion Load LLM** | quantization | `int4` |
| **HYMotion Load LLM** | offload_to_cpu | `True` |
| **HYMotion Load Network** | model_name | `HY-Motion-1.0-Lite` |

---

## 📊 Performance Expectations

| GPU | First Run | Subsequent Runs |
|-----|-----------|-----------------|
| RTX 3070 8GB | ~90s (loading) | ~45-60s |
| RTX 3060 Ti 8GB | ~100s (loading) | ~50-70s |

---

## 🔗 Resources

- [HY-Motion (Tencent)](https://github.com/Tencent-Hunyuan/HY-Motion)
- [ComfyUI-HY-Motion1 Plugin](https://github.com/jtydhr88/ComfyUI-HY-Motion1)
- [top3d.ai Tutorial](https://www.top3d.ai/learn/text-to-animation-hy-motion)
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)

---

## ✅ Setup Checklist

- [ ] Install Miniconda
- [ ] Create Python 3.11 environment (`comfy311`)
- [ ] Clone ComfyUI
- [ ] Install PyTorch with CUDA 12.4
- [ ] Install ComfyUI requirements
- [ ] Clone HY-Motion plugin
- [ ] Install plugin requirements (includes FBX SDK)
- [ ] Download HY-Motion-1.0-Lite model (~1.8GB)
- [ ] Run ComfyUI and test!
