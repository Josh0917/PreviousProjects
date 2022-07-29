import matplotlib
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.stattools import adfuller

#Read xls File
xls = pd.ExcelFile("NATURALGAS.xls")
df = xls.parse(0,skiprows=10,index_col=0,na_valies=['NA'])
#Natural Gas
plt.figure(figsize=(18,6))
plt.grid(True)
plt.xlabel('Month')
plt.ylabel('Natural Gas Consumption in Billion Cubic Feet')
plt.plot(df['NATURALGAS'])
plt.title('Natural Gas Consumption,Monthly')
matplotlib.pyplot.savefig('NATURALGAS',dpi =None, facecolor ='w',orientation='portrait',papertype=None,format=None,transparent=False,bbox_inches=None,pad_inches =.01,frameon=None,metadata=None)
plt.show()
#plot rolling stats
rmean=df.rolling(window=12).mean()
rstd=df.rolling(window=12).std()
rmean.head(20)
orig = plt.plot(df,color='blue',label='Original')
mean = plt.plot(rmean,color='red',label='Rolling Mean')
stdev =plt.plot(rstd,color='black',label = 'Rolling StDev')
plt.legend(loc = 'best')
plt.title('Rolling Mean + Standard Deviation')
plt.show()
#First Dickey_Fuller Test
print("Results of Test")
dftest=adfuller(df['NATURALGAS'],autolag='AIC')
dfoutput = pd.Series(dftest[0:4],index=['Test Stats','p-value','Lags Used','Number of Obs'])
for key, value in dftest[4].items():
    dfoutput['Critical Value (%s)'%key] = value
print(dfoutput)
#LogScale
df_logScale = np.log(df)
plt.plot(df_logScale)
plt.show()
movingMean=df_logScale.rolling(window=12).mean()
movingSTD=df_logScale.rolling(window=12).std()
plt.plot(df_logScale)
plt.plot(movingMean,color='red')
dfScaleminMov = df_logScale-movingMean
dfScaleminMov.head(15)
dfScaleminMov.dropna(inplace=True)
dfScaleminMov.head(15)
matplotlib.pyplot.savefig("logScale",dpi=150)
plt.show()
#TimeSeries
def test_Stationary(timeseries):

    rmean = timeseries.rolling(12).mean()
    rstd = timeseries.rolling(12).std()
    orig = plt.plot(timeseries,color='blue',label='Original')
    mean = plt.plot(rmean,color='red', label ='Rolling Mean')
    std = plt.plot(rstd, color='black',label= 'Rolling StDev')
    plt.legend(loc='best')
    plt.title('Rolling Mean & Standard Deviation')
    matplotlib.pyplot.savefig("TimeSeries", dpi=150)
    plt.show(block=False)

    print("Results")
    adft = adfuller(timeseries,autolag='AIC')
    output=pd.Series(adft[0:4],index = ['Test Stats','p-Value','No. of lags','Observations used'])
    for key,values in adft[4].items():
        output['critical value(%s)'%key]=values
    print(output)
test_Stationary(dfScaleminMov)
#ExponentialDecay
exponentialDecay= df_logScale.ewm(halflife=12,min_periods=0,adjust=True).mean()
plt.plot(df_logScale)
plt.plot(exponentialDecay,color='red')
df_logScaleMinMovExpoDecay=df_logScale - exponentialDecay
test_Stationary(df_logScaleMinMovExpoDecay)
matplotlib.pyplot.savefig("ScaleminMov",dpi=150)
matplotlib.pyplot.show()
#Second Dickey_Fuller Test
print("Results")
logscale = adfuller(df_logScaleMinMovExpoDecay, autolag='AIC')
decayoutput = pd.Series(logscale[0:4], index=['Test Stats', 'p-Value', 'No. of lags', 'Observations used'])
for key, values in logscale[4].items():
        decayoutput['critical value(%s)' % key] = values
print(decayoutput)
#LogShifting
df_LogDiffShifting = df_logScale -df_logScale.shift()
plt.plot(df_LogDiffShifting)
df_LogDiffShifting.dropna(inplace=True)
test_Stationary(df_LogDiffShifting)
matplotlib.pyplot.savefig("LogDiffShift",dpi=150)
plt.show()
#Third Dickey_Fuller Test
print("Results")
LogDiff = adfuller(df_LogDiffShifting, autolag='AIC')
Logoutput = pd.Series(LogDiff[0:4], index=['Test Stats', 'p-Value', 'No. of lags', 'Observations used'])
for key, values in LogDiff[4].items():
        Logoutput['critical value(%s)' % key] = values
print(Logoutput)
#Autocorrelation Function
from statsmodels.tsa.stattools import acf, pacf
lag_acf = acf(df_LogDiffShifting, nlags=20)
lag_pacf = pacf(df_LogDiffShifting, nlags=20, method='ols')
plt.subplot(121)
plt.plot(lag_acf)
plt.axhline(y=0, linestyle='--', color='gray')
plt.axhline(y=-1.96 / np.sqrt(len(df_LogDiffShifting)), linestyle='--', color='gray')
plt.axhline(y=1.96 / np.sqrt(len(df_LogDiffShifting)), linestyle='--', color='gray')
plt.title("Autocorrelation Function")
matplotlib.pyplot.savefig("ACF",dpi=150)
plt.show()
#Partial Auto Correction Function
plt.subplot(122)
plt.plot(lag_pacf)
plt.axhline(y=0, linestyle='--', color='gray')
plt.axhline(y=-1.96 / np.sqrt(len(df_LogDiffShifting)), linestyle='--', color='gray')
plt.axhline(y=1.96 / np.sqrt(len(df_LogDiffShifting)), linestyle='--', color='gray')
plt.title("PartialAutocorrelation Function")
matplotlib.pyplot.savefig("PACF",dpi=150)
plt.show()
#Seasonal TimeSeries
from statsmodels.tsa.seasonal import seasonal_decompose
decomposition = seasonal_decompose(df_logScale)
trend=decomposition.trend
seasonal = decomposition.seasonal
residual = decomposition.resid
plt.subplot(411)
plt.plot(df_logScale,label="original")
plt.legend(loc='best')
plt.subplot(412)
plt.plot(trend,label="Trend")
plt.legend(loc='best')
plt.subplot(413)
plt.plot(seasonal,label="Seasonality")
plt.legend(loc='best')
plt.subplot(414)
plt.plot(residual, label="Residuals")
plt.legend(loc='best')
plt.tight_layout
matplotlib.pyplot.savefig("Seasonal",dpi=150)
plt.show()
#Residual
def test_Stationary(df_decomposedLogData):
    decomposedLogdata = residual
    decomposedLogdata.dropna(inplace=True)
    test_Stationary(decomposedLogdata)
#Fourth Dickey_fuller Test
    print("Results")
    DecomDiff = adfuller(df_decomposedLogData, autolag='AIC')
    Decomoutput = pd.Series(DecomDiff[0:4], index=['Test Stats', 'p-Value', 'No. of lags', 'Observations used'])
    for key, values in DecomDiff[4].items():
        Decomoutput['critical value(%s)' % key] = values
    print(Decomoutput)
# Additive decomposition
# no major effect by depressions
