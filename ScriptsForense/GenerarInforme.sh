import os
import sys
import pandas as pd


def generar_informe_html(ruta_directorio):
    informe = []

    for archivo in os.listdir(ruta_directorio):
        if archivo.endswith('.txt'):
            ruta_archivo_txt = os.path.join(ruta_directorio, archivo)
            df = pd.read_csv(ruta_archivo_txt, sep='\t', header=None)
            informe.append(df.to_html(index=False, header=False, border=0))

    ruta_informe_html = os.path.join(ruta_directorio, 'informe.html')
    with open(ruta_informe_html, 'w') as f:
        f.write('<html><head><style>table {border-collapse: collapse;} td, th {border: 1px solid black; padding: 8px;}</style></head><body>')
        f.write('<h1>Informe de archivos .txt</h1>')
        f.write('<br>'.join(informe))
        f.write('</body></html>')

    print(f'Informe HTML generado en: {ruta_informe_html}')


if __name__ == '__main__':
    if len(sys.argv) > 1:
        ruta_directorio = sys.argv[1]
        generar_informe_html(ruta_directorio)
    else:
        print('Por favor, proporciona la ruta del directorio como argumento.')


