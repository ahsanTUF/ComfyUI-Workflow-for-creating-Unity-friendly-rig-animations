@echo off
echo ============================================
echo   HY-Motion ComfyUI Launcher
echo   RTX 3070 8GB Optimized Setup
echo ============================================
echo.

:: Activate conda environment
call "%USERPROFILE%\miniconda3\Scripts\activate.bat" comfy311

:: Navigate to ComfyUI directory
cd /d "%~dp0ComfyUI_py311"

:: Launch ComfyUI
echo Starting ComfyUI with Python 3.11...
echo.
echo Once started, open: http://127.0.0.1:8188
echo.
echo Workflow files are in:
echo   custom_nodes\ComfyUI-HY-Motion1\workflows\
echo.
python main.py

pause
