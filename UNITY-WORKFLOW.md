# 🎮 Unity Animation Workflow

> **From HY-Motion FBX to Unity-ready animations**

---

## Pipeline Overview

```
HY-Motion → FBX Export → Blender Retargeting → Unity Humanoid
```

---

## 1. Generate Animations (HY-Motion)

1. Launch: `Launch-HYMotion.bat`
2. Open: http://127.0.0.1:8188
3. Load workflow from: `custom_nodes/ComfyUI-HY-Motion1/workflow/`
4. Enter prompt and queue

### Recommended Prompts

| Animation | Prompt | Duration |
|-----------|--------|----------|
| **Sprint** | `A person sprinting at full speed, arms pumping` | 1-2s |
| **Run** | `A person running forward with quick strides` | 2s |
| **Idle** | `A person standing alert, slight breathing motion` | 4-6s |
| **Walk** | `A person walking forward briskly` | 2s |
| **Roll** | `A person doing a quick forward combat roll` | 1s |
| **Jump** | `A person jumping up with arms raised` | 1s |

---

## 2. Retarget in Blender

HY-Motion outputs SMPLX skeleton. To use with your own rig:

### Using Rokoko Plugin (Free)

1. Download: https://www.rokoko.com/integrations/blender
2. Import your rigged character (FBX)
3. Import HY-Motion FBX animation
4. Use Rokoko Retargeting panel to map bones
5. Bake animation to your rig
6. Export as FBX

### Bone Mapping Reference

| SMPLX | Unity Humanoid |
|-------|----------------|
| pelvis | Hips |
| spine1/2/3 | Spine/Chest/UpperChest |
| left_hip → left_ankle | LeftUpperLeg → LeftFoot |
| left_shoulder → left_wrist | LeftUpperArm → LeftHand |

---

## 3. Import to Unity

### Setup Humanoid Avatar

1. Import FBX → Assets folder
2. Select FBX → Inspector → **Rig** tab
3. Animation Type: **Humanoid**
4. Click **Configure** → verify green bones
5. Click **Apply**

### Animation Settings

1. Select FBX → **Animation** tab
2. ✅ Loop Time (for locomotion)
3. ✅ Bake Into Pose
4. Click **Apply**

---

## 4. Animator Controller

```
┌─────────┐     ┌─────────┐     ┌─────────┐
│  Idle   │◄───▶│   Run   │◄───▶│ Sprint  │
└────┬────┘     └────┬────┘     └────┬────┘
     │               │               │
     └───────┬───────┴───────┬───────┘
             ▼               ▼
        ┌─────────┐     ┌─────────┐
        │  Jump   │     │  Roll   │
        └─────────┘     └─────────┘
```

Use **Blend Trees** for smooth locomotion:
- Speed: 0 = Idle, 0.5 = Run, 1 = Sprint

---

## ⚡ Tips for Responsive Animations

1. **Keep animations short**: 1-2 seconds for locomotion
2. **Fast transitions**: 0.1s duration, no exit time
3. **Root Motion OFF**: Code drives movement for responsive controls
4. **Animation Events**: Add for footsteps, effects, gameplay triggers

---

## 📁 Output Structure

```
ComfyUI_py311/output/
└── hymotion_fbx/     ← Generated animations
```
