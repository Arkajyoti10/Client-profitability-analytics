import numpy as np
import pandas as pd

def flag_underperforming_clients(df:pd.DataFrame)->pd.DataFrame:
    net_margin_threshold=df["net_margin_%"].quantile(0.25)
    realization_threshold=df["realization_rate"].quantile(0.25)
    mask=(df["net_margin_%"]<net_margin_threshold) & (df["realization_rate"]<realization_threshold)
    flagged=df[mask]
    return flagged

if __name__=='__main__':
    from extract import get_client_profitability
    df=get_client_profitability()
    flagged=flag_underperforming_clients(df)
    print(flagged[["client_id","net_margin_%","realization_rate"]])
    