# **GENPASS**

Gerador de senhas que inclui também os caracteres com [diacríticos](https://pt.wikipedia.org/wiki/Diacr%C3%ADtico) para aumentar o escopo de símbolos e a segurança

Depende das bibliotecas [yad](https://www.google.com/search?q=linux+yad) para a interface gráfica e [xclip](https://www.google.com/search?q=linux+xclip) para copiar a senha para a área de transferência

Suporta a geração dos textos entre 64 e 2048 caracteres em listas de 1 a 128 itens

Para copiar a senha basta dar duplo click sobre a linha desejada

Caso a cor do ícone precise ser modificada deve-se abrir o arquivo SVG em editor de textos simples e alterar o valor da propriedade *fill* para a nova no formato [hexadecimal](https://www.google.com/search?q=converter+cores+hexadecimal)

Para criar um lançador no ambiente gráfico é necessário definir o caminho para o script e, se necessário, escolher o ícone que está na mesma pasta (não descrevi o processo completo por variar muito entre todas as opções de GUI)

**Instalação dos pacotes necessários (Debian e derivados)**
```terminal
sudo apt install yad xclip
```

**Baixado os arquivos é necessário tornar o script executável**
```terminal
chmod u+x genpass.sh
```

**Para teste direto no terminal**
```terminal
./genpass.sh
```
