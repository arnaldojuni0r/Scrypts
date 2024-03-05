# Caminho para o arquivo de texto contendo os nomes dos arquivos a serem pesquisados
$arquivosTxt = "C:\Users\arnaldo.souza.JALLCARD-DMZ\Desktop\nomes.txt"

# Verifica se o arquivo de texto existe
if (Test-Path $arquivosTxt) {
    # Lê os nomes dos arquivos do arquivo de texto
    $nomesArquivos = Get-Content $arquivosTxt

    # Diretório raiz onde você deseja iniciar a pesquisa
    $diretorioRaiz = "D:\"

    # Itera sobre cada nome de arquivo na lista
    foreach ($nomeArquivo in $nomesArquivos) {
        # Utiliza Get-ChildItem para pesquisar recursivamente o diretório raiz em busca do arquivo
        $arquivosEncontrados = Get-ChildItem -Path $diretorioRaiz -Filter $nomeArquivo -Recurse -ErrorAction SilentlyContinue
        
        # Verifica se foram encontrados arquivos correspondentes ao nome
        if ($arquivosEncontrados) {
            foreach ($arquivoEncontrado in $arquivosEncontrados) {
                Write-Host "Arquivo encontrado: $($arquivoEncontrado.FullName)"
                # Faça aqui o que desejar com o arquivo encontrado, como por exemplo, copiá-lo para outro local
            }
        } else {
            Write-Host "Nenhum arquivo correspondente encontrado para '$nomeArquivo' em '$diretorioRaiz' ou suas subpastas."
        }
    }
} else {
    Write-Host "O arquivo de texto '$arquivosTxt' não foi encontrado."
}
