# -*- coding: utf-8 -*-
"""
Created on Mon Apr 29 14:50:28 2024

@author: namortel
"""

# Install Package Library

pip install yfinance

# Load Package Library

import datetime as dt



#import talib as ta

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

#import datareader as web 
import yfinance as yf

#data = web.datareader("AAPL","yahoo")

#data = web.get_data_yahoo("AAPL")

data = yf.download("PHI", start="2018-01-01", end="2024-04-29")

data

