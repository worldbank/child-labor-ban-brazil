# Replication Package for: [Short- and Long-Term Effects of a Child-Labor Ban](https://elibrary.worldbank.org/doi/abs/10.1596/1813-9450-7796)
Assess the short and long-term effects of a child-labor ban in Brazil (1998).

## Code

#### Main Script
* `0. Master.do`: Main script that runs all code

#### Organization
Code is organized into the `Do files` folder as follows:

* `1. Importing HouseHold Survey (PNAD).do`: The code imports the microdata of the Brazilian Household Survey (Pesquisa Nacional por Amostra de Domicílios). This survey was collected annualy on a representative sample of Brazilian households. (12 minutes to run)
* `2. Harmonizing Household Survey (PNAD).do`: The code harmonizes the PNAD waves from 1998 to 2015, creating the dependent and independent variables of our analysis. (23 minutes tu run)
* `3. Setting up Paper Data.do`: The code It creates the running variable of our study. The code defines the same covariates used in the Bargain/Boutin Paper (2021) 'Minimum Age Regulation and Child Labor'. Therefore, we can compare our and their sample sizes, as well as explain why some results differ. (Less than a minute to run)
* `4. Descriptives.do`: It creates descriptives statistics and figures used in the paper. (A few minutes to run)
* `5. Rdrobust.do`: RD robust estimations. (A few minutes to run)
* `6. Continuity Based Design.do`: Continuity based approach estimates and runs multiple hyphotesis tests
* `7. RDD using Local Randomization.do`: Local Randomization estimates. 
* `Appendix.do`

**Note:** in do-file `1. Importing HouseHold Survey (PNAD).do`, the link to install `datazoom_pnad` needs to be updated.

## Data

### Datasets that need to be manually downloaded
The following datasets need to be manually downloaded: PESQUISA NACIONAL POR AMOSTRA DE DOMICÍLIOS (PNAD)

The .txt files are available in IBGE (Brazilian Institute od Geography and Statistics) website. 
					
* Since  2001 waves, download the microdata in: https://www.ibge.gov.br/estatisticas/sociais/trabalho/19897-sintese-de-indicadores-pnad2.html?=&t=microdados
* Before 2001, download the microdata in: https://loja.ibge.gov.br/pnad-1987-a-1999-microdados.html

The dictionaries to read .txt files: 

*  Between 1998 to 2014: we used the DataZoom tool created by PUC/RIO University to import the data without having to manually create the dictionary of the variables. 
* For 2015, we created our own dictionary due to an error we identified in the tool. 

## To replicate analysis
It is possible to reproduce all the analysis using only the codes available in GitHub. 

Set up the folder structure:

1. Create the folder "child-labor-ban-brazil".
2. Inside this folder, create "DataWork"
3. Inside "DataWork", create "Datasets" 
4. Inside "Datasets", create 3 folders: "Raw", "Intermediate" and "Final" 
5. Inside "Raw", create 16 folders for each PNAD wave. The folders need to be named: 1998, 1999, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015. 
6. Inside "DataWork", create "Output" 
7. Inside "Output", create 2 folders: "Tables" and "Figures".

For each wave, save the PNAD microdata in the respective folder. For example, for 1999 wave, save the .txt files in the folder: child-labor-ban-brazil->DataWork->Datasets->Raw->1999. 
		
Make sure that the .txt files are saved with the following names:
* 1998 -> Pessoa98.txt Domicilio98.txt
* 1999 -> Pessoa99.txt Domicilio99.txt
* 2001 -> PES2001.txt  DOM2001.txt
* 2002 -> PES2002.txt  DOM2002.txt
* 2003 -> PES2003.txt  DOM2003.txt
* 2004 -> PES2004.txt  DOM2004.txt
* 2005 -> PES2005.txt  DOM2005.txt
* 2006 -> PES2006.txt  DOM2006.txt
* 2007 -> PES2007.txt  DOM2007.txt
* 2008 -> PES2008.txt  DOM2008.txt
* 2009 -> PES2009.txt  DOM2009.txt
* 2011 -> PES2011.txt  DOM2011.txt
* 2012 -> PES2012.txt  DOM2012.txt
* 2013 -> PES2013.txt  DOM2013.txt
* 2014 -> PES2014.txt  DOM2014.txt
* 2015 -> PES2015.txt  DOM2015.txt			
		
After setting up the folder structure and saving Household Survey Microdata (in .txt files), you can run the codes and reproduce all the results. 
