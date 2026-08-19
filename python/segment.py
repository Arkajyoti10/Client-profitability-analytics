import numpy as np
import pandas as pd

def segment_clients(df:pd.DataFrame) ->pd.DataFrame:
    revenue_median=df["total_revenue"].median()
    margin_median=df["net_margin_%"].median()

    conditions=[
        (df["total_revenue"]>revenue_median) & (df["net_margin_%"]>margin_median),
        (df["total_revenue"]>revenue_median) & (df["net_margin_%"]<=margin_median),
        (df["total_revenue"]<=revenue_median) & (df["net_margin_%"]>margin_median),
        (df["total_revenue"]<=revenue_median) & (df["net_margin_%"]<=margin_median),
    ]

    labels=[
        "High Revenue/High Margin",
        "High Revenue/Low Margin",
        "Low Revenue/High Margin",
        "Low Revenue/Low Margin" ,  
    ]

    df["segment"]=np.select(conditions,labels,default="Unclassified")

    return df

if __name__=='__main__':
    from extract import get_client_profitability

    df=get_client_profitability()
    segmented=segment_clients(df)
    print(segmented[["client_id","total_revenue","net_margin_%","segment"]])
    print(segmented["segment"].value_counts())