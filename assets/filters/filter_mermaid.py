import panflute as pf

def action(elem, doc):
    if (isinstance(elem, pf.Code) or
        isinstance(elem, pf.CodeBlock)):
        if ('mermaid' in elem.classes):
            return []

if __name__ == '__main__':
    pf.toJSONFilter(action)