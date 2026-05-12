#!/usr/bin/env python3
"""生成软著申请所需的文档鉴别材料 PDF（操作说明书，支持嵌入真实界面截图）"""
import os
import re

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import (
    Image as RLImage,
    PageBreak,
    Paragraph,
    Preformatted,
    SimpleDocTemplate,
    Spacer,
)

LINES_PER_PAGE = 30
PAGES_NEEDED = 30
HEADER = "数独-可爱桔软件 V1.0 操作说明书"
IMG_TAG = re.compile(r"^@@IMG:(.+)@@\s*$")
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
IMG_MAX_W = 16 * cm


def setup_font():
    font_paths = [
        "/System/Library/Fonts/Supplemental/Arial Unicode.ttf",
        "/Library/Fonts/Arial Unicode.ttf",
        "/System/Library/Fonts/Hiragino Sans GB.ttc",
    ]
    for path in font_paths:
        if os.path.exists(path):
            try:
                pdfmetrics.registerFont(TTFont("UnicodeFont", path))
                return "UnicodeFont"
            except Exception:
                pass
    return "Helvetica"


def parse_blocks(lines):
    blocks = []
    buf = []
    for line in lines:
        m = IMG_TAG.match(line.rstrip("\n"))
        if m:
            if buf:
                blocks.append(("text", buf))
                buf = []
            rel = m.group(1).strip()
            blocks.append(("img", rel))
        else:
            buf.append(line)
    if buf:
        blocks.append(("text", buf))
    return blocks


def file_has_images(blocks):
    return any(b[0] == "img" for b in blocks)


def paginate_text_lines(lines, lines_per_page):
    non_empty = [l if l.strip() else "\n" for l in lines]
    total = len(non_empty)
    needed = lines_per_page * PAGES_NEEDED
    if total <= needed:
        return non_empty, []
    return non_empty[:needed], non_empty[-needed:]


def make_image_flowable(rel_path, font_name):
    abs_path = os.path.normpath(os.path.join(BASE_DIR, rel_path))
    caption_style = ParagraphStyle(
        name="Cap",
        fontName=font_name,
        fontSize=9,
        leading=12,
        spaceBefore=4,
        spaceAfter=8,
    )
    cap_text = f"（界面截图：{rel_path}）"
    if os.path.isfile(abs_path):
        try:
            img = RLImage(abs_path, width=IMG_MAX_W)
            return [img, Paragraph(cap_text, caption_style), PageBreak()]
        except Exception:
            pass
    warn = (
        f"【请补图】将本软件运行界面截图保存为：<b>{rel_path}</b>，"
        f"置于「软著素材」目录下相对路径，重新运行本脚本生成 PDF。"
    )
    placeholder_style = ParagraphStyle(
        name="Ph",
        fontName=font_name,
        fontSize=9,
        leading=12,
        backColor=colors.lightgrey,
        borderPadding=8,
        spaceAfter=8,
    )
    return [
        Spacer(1, 0.8 * cm),
        Paragraph(warn, placeholder_style),
        Spacer(1, 0.5 * cm),
        PageBreak(),
    ]


def add_text_pages(story, part, font_name, style, header_para):
    for page_idx in range(0, len(part), LINES_PER_PAGE):
        page_lines = part[page_idx : page_idx + LINES_PER_PAGE]
        story.append(header_para)
        story.append(Paragraph("<br/>", style))
        text = "".join(page_lines).replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        story.append(Preformatted(text, style))
        if page_idx + LINES_PER_PAGE < len(part):
            story.append(PageBreak())


def build_story_from_blocks(blocks, font_name, style, header_para, truncate):
    story = []
    for kind, payload in blocks:
        if kind == "text":
            if truncate:
                first, last = paginate_text_lines(payload, LINES_PER_PAGE)
                add_text_pages(story, first, font_name, style, header_para)
                if last and last != first:
                    story.append(PageBreak())
                    add_text_pages(story, last, font_name, style, header_para)
            else:
                add_text_pages(story, payload, font_name, style, header_para)
        else:
            story.append(PageBreak())
            story.append(header_para)
            story.append(Spacer(1, 0.2 * cm))
            story.extend(make_image_flowable(payload, font_name))
    return story


def main():
    os.chdir(BASE_DIR)
    src_path = "操作说明书.txt"
    with open(src_path, "r", encoding="utf-8", errors="replace") as f:
        lines = f.readlines()

    blocks = parse_blocks(lines)
    font_name = setup_font()
    style = ParagraphStyle(
        name="Doc",
        fontName=font_name,
        fontSize=10.5,
        leading=14,
        leftIndent=0,
        spaceBefore=2,
        spaceAfter=2,
    )
    header_para = Paragraph(
        f"<b>{HEADER}</b>",
        ParagraphStyle(name="Header", fontName=font_name, fontSize=9, alignment=1),
    )

    has_img = file_has_images(blocks)
    truncate = not has_img

    story = build_story_from_blocks(blocks, font_name, style, header_para, truncate)

    doc = SimpleDocTemplate(
        "文档鉴别材料_操作说明书.pdf",
        pagesize=A4,
        rightMargin=2 * cm,
        leftMargin=2 * cm,
        topMargin=2.5 * cm,
        bottomMargin=2 * cm,
    )
    doc.build(story)
    print("已生成: 文档鉴别材料_操作说明书.pdf")
    if has_img:
        print("已启用配图模式：全文输出（不按 900 行截断）。若总页数超过 60，请按版权中心要求另取前 30+后 30 页导出。")
        print("截图目录：软著素材/screenshots/，清单见 screenshots/截图说明.txt")
    else:
        print(
            f"纯文本模式：前{PAGES_NEEDED}页+后{PAGES_NEEDED}页（总行数过多时自动截断）。"
            "若需图文版，请在操作说明书.txt 中加入 @@IMG:相对路径@@ 并放置对应 PNG。"
        )


if __name__ == "__main__":
    main()
