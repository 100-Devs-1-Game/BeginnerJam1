#!/usr/bin/env python3
from PIL import Image
import os
import fnmatch

ASSETS_DIR = os.path.dirname(os.path.abspath(__file__))  # Use the path we're executing from

def scale_up_image(path):
    """Scale up image by a factor of 2"""
    try:
        img = Image.open(path)
        width, height = img.size
        
        new_width = width * 2
        new_height = height * 2
        
        print(f"Scaling {path}: {width}x{height} -> {new_width}x{new_height}")
        resized = img.resize((new_width, new_height), resample=Image.Resampling.NEAREST)
        resized.save(path)
            
    except Exception as e:
        print(f"Error converting image {path}: {e}")

def main():
    if not os.path.exists(ASSETS_DIR):
        print(f"Error: Assets directory '{ASSETS_DIR}' not found")
        return
    
    # Find all PNG files recursively
    files = [
        os.path.join(dirpath, f)
        for dirpath, dirnames, files in os.walk(ASSETS_DIR)
        for f in fnmatch.filter(files, "*.png")
    ]
    
    print(f"Found {len(files)} PNG files")
    
    for f in files:
        scale_up_image(f)
    
    print("Done!")

if __name__ == '__main__':
    main()