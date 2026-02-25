#!/usr/bin/env python3
"""生成软著申请所需的文档鉴别材料 PDF（操作说明书，前30页+后30页）"""
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import cm
from reportlab.platypus import SimpleDocTemplate, Paragraph, Preformatted, PageBreak
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
import os

def setup_font():
    font_paths = [
        '/System/Library/Fonts/Supplemental/Arial Unicode.ttf',
        '/Library/Fonts/Arial Unicode.ttf',
        '/System/Library/Fonts/Hiragino Sans GB.ttc',
    ]
    for path in font_paths:
        if os.path.exists(path):
            try:
                pdfmetrics.registerFont(TTFont('UnicodeFont', path))
                return 'UnicodeFont'
            except Exception:
                pass
    return 'Helvetica'

LINES_PER_PAGE = 30
PAGES_NEEDED = 30
HEADER = "数独-可爱桔软件 V1.0 操作说明书"

def main():
    with open('操作说明书.txt', 'r', encoding='utf-8', errors='replace') as f:
        lines = f.readlines()
    
    # 保留所有行，确保每页约30行
    non_empty = [l if l.strip() else '\n' for l in lines]
    total = len(non_empty)
    needed = LINES_PER_PAGE * PAGES_NEEDED  # 900 lines for 30 pages
    
    if total <= needed:
        first_part = non_empty
        last_part = []
    else:
        first_part = non_empty[:needed]
        last_part = non_empty[-needed:]
    
    font_name = setup_font()
    
    doc = SimpleDocTemplate(
        '文档鉴别材料_操作说明书.pdf',
        pagesize=A4,
        rightMargin=2*cm,
        leftMargin=2*cm,
        topMargin=2.5*cm,
        bottomMargin=2*cm,
    )
    
    story = []
    style = ParagraphStyle(
        name='Doc',
        fontName=font_name,
        fontSize=10.5,
        leading=14,
        leftIndent=0,
        spaceBefore=2,
        spaceAfter=2,
    )
    
    def add_pages(part):
        for page_idx in range(0, len(part), LINES_PER_PAGE):
            page_lines = part[page_idx:page_idx + LINES_PER_PAGE]
            header = Paragraph(f'<b>{HEADER}</b>', ParagraphStyle(
                name='Header', fontName=font_name, fontSize=9, alignment=1
            ))
            story.append(header)
            story.append(Paragraph('<br/>', style))
            text = ''.join(page_lines).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            story.append(Preformatted(text, style))
            if page_idx + LINES_PER_PAGE < len(part):
                story.append(PageBreak())
    
    add_pages(first_part)
    if last_part and last_part != first_part:
        story.append(PageBreak())
        add_pages(last_part)
    
    doc.build(story)
    print('已生成: 文档鉴别材料_操作说明书.pdf')
    print(f'页数: 前{min(30, (len(first_part)-1)//LINES_PER_PAGE+1)}页 + 后{min(30, (len(last_part)-1)//LINES_PER_PAGE+1) if last_part else 0}页')

if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    main()
