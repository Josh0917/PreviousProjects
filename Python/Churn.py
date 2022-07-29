from statistics import variance

import matplotlib
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import csv
#%matplotlib inline
import math
df = pd.read_csv('Churn_Modelling.csv')
print(df.head())
print(df.tail())
df.isnull()
df.dropna()
df.isna()
df.isnull().sum()
df.info()
df.describe()
creditScore = df['CreditScore']
age= df['Age']
tenure = df['Tenure']
balance = df['Balance']
estimatedSalary = df['EstimatedSalary']

print("Variance of Credit Score is % s"%(variance(creditScore)))
print("Variance of Age is % s"%(variance(age)))
print("Variance of Tenure is % s"%(variance(tenure)))
print("Variance of Balance is % s"%(variance(balance)))
print("Variance of Estimated Salary is % s"%(variance(estimatedSalary)))
#churned v not churned
sns.countplot(x='Exited', data=df)
matplotlib.pyplot.savefig("churned")
plt.show()
#percentage churned
total_customers = len(df.index)
customers_churned = df.groupby('Exited').Exited.count()[1]
percent = customers_churned/total_customers
print(percent)
#histo
df['CreditScore'].plot.hist(bins=100,figsize=(10,5))
#unique values
df['Geography'].unique()
# geography of customers
sns.countplot(x='Geography',hue='Exited',data=df)
matplotlib.pyplot.savefig("geography")
plt.show()
#churned geogaphy
sns.countplot(x='Geography',hue='Exited',data=df)
matplotlib.pyplot.savefig("Churned Geography")
plt.show()
#gender churn
sns.countplot(x="Exited",hue="Gender",data=df)
matplotlib.pyplot.savefig("gender churn")
plt.show()
#percentage gender
churned_by_gender=df.groupby(['Gender'])['Exited'].sum()
print(churned_by_gender)
#churned number
churned_males = churned_by_gender['Male']
churned_females = churned_by_gender['Female']
print('Churned males:' +str(churned_males))
print('Churned Females:' +str(churned_females))
#histogram of age
df['Age'].plot.hist()
#boxplot churned age
sns.boxplot(x="Exited", y="Age", data=df)
matplotlib.pyplot.savefig("churned age")
plt.show()
#tenure for churned
sns.countplot(x='Tenure',hue='Exited',data=df)
matplotlib.pyplot.savefig("tenure churned")
plt.show()
df['Balance'].plot.hist()
sns.countplot(x='NumOfProducts',hue='Exited',data=df)
matplotlib.pyplot.savefig("Products churned")
plt.show()
#credit card ownership
sns.countplot(x="HasCrCard",hue="Exited",data=df)
matplotlib.pyplot.savefig("credit card")
plt.show()
#credit card churn
churned_by_cc=df.groupby(['HasCrCard'])['Exited'].sum()
churned_no_cc = churned_by_cc[0]
churned_cc=churned_by_cc[1]
print('Churned with no credit card:'+str(churned_no_cc))
print('Churned with credit card:'+str(churned_cc))
#active hours
sns.countplot(x='IsActiveMember',hue="Exited",data=df)
matplotlib.pyplot.savefig("active hours")
plt.show()
#salary
df['EstimatedSalary'].plot.hist(bins=10000,figsize=(10,5))