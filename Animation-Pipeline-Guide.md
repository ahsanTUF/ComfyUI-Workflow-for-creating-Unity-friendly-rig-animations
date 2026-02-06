# Unity FPS Tag Game — Animation Pipeline Guide

> **Complete workflow from character creation to Unity-ready animations**  
> **Hardware:** RTX 3070 8GB | **Characters:** 4 body variants

---

## 📋 Pipeline Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  1. CHARACTER   │───▶│    2. RIGGING   │───▶│  3. ANIMATION   │───▶│   4. UNITY      │
│    MODELING     │    │                 │    │   GENERATION    │    │   IMPORT        │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
     Blender              AccuRIG              HY-Motion              Humanoid Avatar
     or AI Tools          (Free)               (This Setup)           Retargeting
```

---

## 🎭 Your 4 Character Variants

| Character | Body Type | Animation Priority |
|-----------|-----------|-------------------|
| **Agile** | Small, lean | Fast transitions, quick rolls |
| **Mischievous** | Average | Snappy, playful movements |
| **Big Chungus** | Large, heavy | Momentum-based, weighted |
| **Tech/Grapple** | Medium, tactical | Precision, hook animations |

> [!TIP]  
> **Unity Humanoid System** lets you create ONE animation set and apply it to ALL 4 characters. Unity auto-retargets animations between different body proportions.

---

## 🔧 Part 1: Character Creation (Free Tools)

### Option A: AI-Assisted Character Creation

| Tool | What It Does | Link |
|------|--------------|------|
| **Meshy.ai** | Text-to-3D character (free tier) | https://meshy.ai |
| **Tripo3D** | Text-to-3D model generation | https://tripo3d.ai |
| **ReadyPlayerMe** | Customizable game avatars | https://readyplayer.me |

### Option B: Blender Character Modeling

For custom low-poly game characters:
1. Use **MB-Lab** addon (free human generator)
2. Or model manually using reference images
3. Decimate for game-ready poly counts (~5K-15K triangles)

---

## 🦴 Part 2: Rigging (Free Tools)

### AccuRIG (Recommended - Free & Easy)

1. Go to: https://actorcore.reallusion.com/AccuRIG
2. Upload your character mesh
3. Auto-generates Unity-compatible rig
4. Download as FBX

### Mixamo (Alternative)

1. Go to: https://mixamo.com
2. Upload character → Auto-rigged
3. Export with skeleton only (no animations)

### Rigify (Blender Built-in)

For Blender-native workflow:
1. Enable Rigify addon in Blender preferences
2. Add Human Meta-Rig → position bones
3. Generate Rig → parent mesh with automatic weights

---

## 🎬 Part 3: Animation Generation (HY-Motion)

### Quick Start

1. **Double-click** `Launch-HYMotion.bat` in this folder
2. Open browser: `http://127.0.0.1:8188`
3. Drag `workflow.json` from: `ComfyUI_py311\custom_nodes\ComfyUI-HY-Motion1\workflows\`

### Optimized Settings for 8GB VRAM

| Setting | Value | Why |
|---------|-------|-----|
| Model | HY-Motion-1.0-Lite | Fits in VRAM |
| Text Encoder | int4 | Lower memory |
| Duration | 2-4 seconds | Short loops |
| CFG Scale | 5 | Good quality/speed |

---

## 🎮 Animation Prompts for Your Game

### Core Locomotion (Fast, Looping)

| Animation | Prompt | Duration |
|-----------|--------|----------|
| **Sprint** | `A person sprinting at full speed, arms pumping, athletic form, fast paced` | 1-2s |
| **Run** | `A person running forward with quick strides, game character movement` | 2s |
| **Idle** | `A person standing alert, slight breathing motion, ready stance, subtle weight shift` | 4-6s |
| **Walk** | `A person walking forward briskly, confident stride` | 2s |

### Parkour Actions

| Animation | Prompt | Duration |
|-----------|--------|----------|
| **Slide** | `A person sliding on the ground feet first, arms back for balance, baseball slide motion` | 1-2s |
| **Roll** | `A person doing a quick forward combat roll, tucking and rolling smoothly` | 1s |
| **Jump** | `A person jumping up with arms raised, athletic leap, game character` | 1s |
| **Wall Run Start** | `A person leaping toward a wall at an angle, body tilting, parkour transition` | 1s |
| **Wall Run Loop** | `A person running along a vertical wall horizontally, parkour wall run, sideways stride` | 2s |

### Special Animations (For Later)

| Animation | Prompt | Duration |
|-----------|--------|----------|
| **Gravity Flip** | `A person transitioning from floor to ceiling, body inverting, floating rotation` | 2s |
| **Grapple Swing** | `A person swinging on a rope, momentum swing, one arm extended holding rope` | 2-3s |
| **Victory Emote** | `A person doing a celebratory fist pump and dance, energetic celebration` | 3-4s |
| **Tag Emote** | `A person doing a playful taunt, hand wave and laugh, mischievous gesture` | 2-3s |

---

## 🔄 Part 4: Retargeting to Your Rig (Blender)

### Method: Rokoko Studio (Free)

1. **Download** Rokoko Blender Plugin: https://www.rokoko.com/integrations/blender
2. Install in Blender → Edit → Preferences → Add-ons
3. Import your rigged character (FBX)
4. Import HY-Motion FBX animation
5. Use Rokoko Retargeting panel to map bones
6. Bake animation to your rig
7. Export as FBX for Unity

### Bone Mapping Quick Reference

| SMPLX Bone | Unity Humanoid |
|------------|----------------|
| pelvis | Hips |
| spine1/2/3 | Spine/Chest/UpperChest |
| left_hip → left_ankle | LeftUpperLeg → LeftFoot |
| left_shoulder → left_wrist | LeftUpperArm → LeftHand |
| head | Head |

---

## 🎮 Part 5: Unity Import Workflow

### Setup Humanoid Avatar

1. **Import FBX** into Unity (drag into Assets folder)
2. Select FBX → Inspector → **Rig** tab
3. Set Animation Type: **Humanoid**
4. Click **Configure** → verify green bones
5. Click **Apply**

### Import Animations

1. Select animation FBX → Inspector → **Animation** tab
2. ✅ Loop Time (for locomotion)
3. ✅ Bake Into Pose (for root motion control)
4. Click **Apply**

### Animator Controller Setup

```
┌─────────┐     ┌─────────┐     ┌─────────┐
│  Idle   │◄───▶│   Run   │◄───▶│ Sprint  │
└────┬────┘     └────┬────┘     └────┬────┘
     │               │               │
     └───────┬───────┴───────┬───────┘
             ▼               ▼
        ┌─────────┐     ┌─────────┐
        │  Jump   │     │  Slide  │
        └─────────┘     └─────────┘
```

Use **Blend Trees** for smooth locomotion:
- Speed parameter: 0 = Idle, 0.5 = Run, 1 = Sprint

---

## ⚡ Tips for Snappy, Responsive Animations

### 1. Keep Animations Short
- Locomotion loops: 1-2 seconds max
- Shorter = faster blending

### 2. Use Transition Settings
```csharp
// In Animator transitions:
Transition Duration: 0.1s  // Very fast blend
Has Exit Time: false       // Immediate response
```

### 3. Root Motion vs In-Place
- **Root Motion ON**: Animation drives movement (realistic)
- **Root Motion OFF**: Code drives movement (responsive)
- For fast-paced games: **OFF** is usually better

### 4. Animation Events
Add events at key frames for:
- Footstep sounds
- Particle effects
- Gameplay triggers

---

## 📁 Output Folder Structure

```
Hunyuan 3D local animations/
├── Launch-HYMotion.bat          ← Double-click to start
├── HY-Motion-Setup-Guide.md     ← Setup reference
├── Animation-Pipeline-Guide.md  ← This file
├── ComfyUI_py311/               ← ComfyUI installation
│   └── output/
│       └── hymotion_fbx/        ← Generated animations go here
└── Unity Exports/               ← Create this for processed FBX files
    ├── Agile/
    ├── Mischievous/
    ├── BigChungus/
    └── Tech/
```

---

## ✅ Quick Checklist

- [ ] Create/obtain 4 character models
- [ ] Rig characters with AccuRIG or Mixamo
- [ ] Generate base animations with HY-Motion
- [ ] Retarget to character rigs in Blender
- [ ] Export to Unity as Humanoid FBX
- [ ] Set up Animator Controller with Blend Trees
- [ ] Configure fast transition times (0.1s)
- [ ] Test responsiveness in game
