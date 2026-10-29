"""Inspect and render the checked-in ADC GDS using KLayout's Python API."""

from pathlib import Path
import json
import pya


ROOT = Path(__file__).resolve().parents[1]
GDS = ROOT / "results" / "layout" / "klayout_gds" / "adc_top.klayout.gds"
OUT = ROOT / "site" / "adc_top.png"
META = ROOT / "site" / "layout_metadata.json"

if not GDS.is_file():
    raise SystemExit(f"GDS file not found: {GDS}")

layout = pya.Layout()
layout.read(str(GDS))
tops = list(layout.top_cells())
if not tops:
    raise SystemExit("GDS contains no top-level cells")

view = pya.LayoutView()
view.load_layout(str(GDS), True)
view.max_hier()
view.zoom_fit()
OUT.parent.mkdir(parents=True, exist_ok=True)
view.save_image(str(OUT), 1800, 1200)

META.write_text(json.dumps({
    "file": GDS.name,
    "top_cells": [cell.name for cell in tops],
    "dbu_um": layout.dbu,
    "bounding_box_um": [
        tops[0].dbbox().left, tops[0].dbbox().bottom,
        tops[0].dbbox().right, tops[0].dbbox().top,
    ],
    "layers": [str(info) for info in layout.layer_infos()],
}, indent=2) + "\n", encoding="utf-8")
print(f"Read {GDS}: {len(tops)} top-level cell(s), {len(list(layout.layer_infos()))} layers")
print(f"Rendered {OUT}")
