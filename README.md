## Introduction<br>
This is a project I worked on during my employement at Qwince.
While I intend to showcase my code and analysis, I have chosen to maintain the confidentiality of my research by refraining from disclosing its actual subject and location. For the purposes of this presentation, I will refer to my research as

> **An Analysis on affluence to ancient greek temples**

I also need to specify, the information is not historically or culturally accurate, I simply chose it as a fun way to present my analysis.
<br>

## Database description<br>
My database tracked informations about every visit to the temples we followed. It was split in 4 tables, as reported in the following image:

tracked informations about invoice exchanges between blacksmiths and suppliers. As it can be seen in the following image, the database has three main section: one identifies the blacksmith, one identifies the supplier, and one gives information on each invoice in terms of id, date and cost.<br>

![overview](https://github.com/ludovicato/Analysis_Affluence_to_Temples/assets/119680854/3629283e-14b8-4170-a000-d33c0832d0ab)







## My analysis<br>
The purpose of my research was to analyze the invoice exchanges between blacksmiths and suppliers in order to identify trends and patterns. To achieve this, I first had to clean and prepare the data, which was a challenging task due to its large size and formatting issues. Once the data was ready, I analyzed the number of invoices and total amount produced in various regions and over time, as well as the strength and scale of the suppliers involved. I also mapped out the main center of activity by joining the data with a database of provincial coordinates. To gain a better understanding of the national and regional blacksmith market, I then proceeded to join the data with a database of all blacksmiths and calculated the percentage that we were monitoring. <br>

For this analysis, I primarily utilized PostgreSQL, but I also incorporated a range of other tools and platforms, including the BI tool Looker Studio, Microsoft Excel, Microsoft PowerPoint, and even Adobe Photoshop to create a more personalized look for my presentation. Additionally, I even employed ChatGPT to aid in certain aspects of the project.<br>

Displayed below is an example of the graphic elements included in the presentation, which illustrate the distribution of invoices produced in each region.

<img width="1146" alt="preview" src="https://user-images.githubusercontent.com/119680854/219099204-d3488f4c-0343-43a5-923c-bb7ce21d77ca.png">

My future plans for this research include repeating these analyses on data from the previous two years and making predictions for the following year. I will then proceed to confront the prediction to the actual data of the following year, which I have already aquired, to test its accuracy and, if the results will be positive, I will incorporate that year as well to generate predictions for the year after. <br>
I also intend to acquire and analyze the content of the invoices to categorize the suppliers and gain further insights into the blacksmith-supplier relationship. <br>


## Highlights<br>
Here, you can find some of the key highlights of the code I use and view examples of the results. To explore the rest of the code, you can access it from this [link](https://github.com/ludovicato/SQL_Analysis_Blacksmiths_in_Westeros/blob/92cffb3e584766b9728a88922ca8091d0241c7c5/main_queries.sql) or check the other documents in this repository. 

![1](https://user-images.githubusercontent.com/119680854/219635907-d65680dd-7646-4275-a0a5-7e74dd385c29.png)

![2](https://user-images.githubusercontent.com/119680854/219635949-65be1515-bc98-4477-b0bb-5c55636994ed.png)

![3](https://user-images.githubusercontent.com/119680854/219635993-1187b711-6e6e-47a2-bd37-85ac6613c530.png)

![5](https://user-images.githubusercontent.com/119680854/219636027-3cb85d07-2002-4a4e-a52b-569848a3a407.png)

![6](https://user-images.githubusercontent.com/119680854/219636052-16bac4a7-0987-4a5f-9d75-568aab607966.png)
