#Biblioteca utilizada

install.packages('rvest')

library(rvest)

#Acessando o site de interesse - Ex.: volume 31 - Revista EM QUESTÃO

fonte<-read_html("https://seer.ufrgs.br/index.php/EmQuestao/issue/view/5170")

#Extração de títulos

titulos <- fonte %>% #Acessa a fonte de dados 
html_nodes(".title") %>% #indica a classe a ser raspada
html_text2() #extrai os textos presentes na classe

#Organizando os Títulos

titulos<-titulos[1:26]

#Extração de autores

autores <- fonte %>% #Acessa a fonte de dados 
html_nodes(".authors") %>% #indica a classe a ser raspada
html_text2() #extrai os textos presentes na classe

#Organizando autores

autores<-autores[1:26]

#Extração de links

links<-fonte %>%
  html_nodes(".title a") %>%
  html_attr("href")

#Organizando links

links<-links[1:26]

#Tabela de dados

dados<-data.frame("Título"=titulos, "Autores"=autores, "Links"=links)

View(dados)

write.table(dados, "tabela_artigos.txt", sep = "\t", row.names = F)

#Extração utilizando query na busca

fonte_2<-read_html("https://seer.ufrgs.br/index.php/EmQuestao/search?query=Bibliometria")

titulos_2 <- fonte_2 %>% #Acessa a fonte de dados 
  html_nodes(".title") %>% #indica a classe a ser raspada
  html_text2() #extrai os textos presentes na classe

titulos_2<-titulos_2[1:98]

autores_2 <- fonte_2 %>% #Acessa a fonte de dados 
  html_nodes(".authors") %>% #indica a classe a ser raspada
  html_text2() #extrai os textos presentes na classe

autores_2<-autores_2[1:98]

anos <- fonte_2 %>% #Acessa a fonte de dados 
  html_nodes(".published") %>% #indica a classe a ser raspada
  html_text2() #extrai os textos presentes na classe

links_2<-fonte_2 %>%
  html_nodes(".title a") %>%
  html_attr("href")

dados_2<-data.frame("Título"=titulos_2, "Autores"=autores_2, "Anos"=anos, "Links"=links_2)

dados_2$Anos <- substr(dados_2$Anos, 1, 4) #extrai somente os anos

View(dados_2)

write.table(dados_2, "tabela_artigos_2.txt", sep = "\t", row.names = F) #salva dataframe

#Visualização da evolucao temporal

tabela_anos<-table(dados_2$Anos) #Cria tabela de frequencia dos anos

tabela_anos

barplot(tabela_anos) #Gráfico de barras

plot(tabela_anos, type = "o") #Gráfico de linhas