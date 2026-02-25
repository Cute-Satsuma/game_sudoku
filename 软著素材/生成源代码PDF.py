#!/usr/bin/env python3
"""生成软著申请所需的源代码 PDF（前30页+后30页）"""
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import cm
from reportlab.platypus import SimpleDocTemplate, Paragraph, Preformatted, PageBreak
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
import os

# 使用支持 Unicode 的字体，避免中文乱码
def setup_font():
    font_paths = [
        '/System/Library/Fonts/Supplemental/Arial Unicode.ttf',
        '/Library/Fonts/Arial Unicode.ttf',
        '/System/Library/Fonts/Hiragino Sans GB.ttc',
    ]
    for path in font_paths:
        if os.path.exists(path):
            try:
                name = 'UnicodeFont'
                pdfmetrics.registerFont(TTFont(name, path))
                return name
            except Exception:
                pass
    return 'Helvetica'

LINES_PER_PAGE = 50
PAGES_NEEDED = 30
HEADER = "数独-可爱桔软件 V1.0"

def main():
    with open('源代码合并.txt', 'r', encoding='utf-8', errors='replace') as f:
        lines = f.readlines()
    
    total = len(lines)
    needed = LINES_PER_PAGE * PAGES_NEEDED  # 1500 lines
    
    if total <= needed:
        first_part = lines
        last_part = []
    else:
        first_part = lines[:needed]
        last_part = lines[-needed:]
    
    font_name = setup_font()
    
    doc = SimpleDocTemplate(
        '程序鉴别材料_源代码.pdf',
        pagesize=A4,
        rightMargin=2*cm,
        leftMargin=2*cm,
        topMargin=2.5*cm,
        bottomMargin=2*cm,
    )
    
    story = []
    style = ParagraphStyle(
        name='Code',
        fontName=font_name,
        fontSize=9,
        leading=11,
        leftIndent=0,
    )
    
    def add_pages(part, start_label):
        for page_idx in range(0, len(part), LINES_PER_PAGE):
            page_lines = part[page_idx:page_idx + LINES_PER_PAGE]
            # 页眉
            header = Paragraph(f'<b>{HEADER}</b>', ParagraphStyle(
                name='Header', fontName=font_name, fontSize=9, alignment=1
            ))
            story.append(header)
            story.append(Paragraph('<br/>', style))
            # 代码（转义 XML 特殊字符，避免解析错误）
            text = ''.join(page_lines).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            story.append(Preformatted(text, style))
            if page_idx + LINES_PER_PAGE < len(part):
                story.append(PageBreak())
    
    add_pages(first_part, "前")
    if last_part and last_part != first_part:
        story.append(PageBreak())
        add_pages(last_part, "后")
    
    doc.build(story)
    print('已生成: 程序鉴别材料_源代码.pdf')

if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    main()
