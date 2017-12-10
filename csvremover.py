import pandas as pd

#columns to keep: hh_id(5), time(10), mileage(12), event(13), ro_event(14), ro(15), 2ormore(204), asian(205), black(206), hawaii(207)
#

list1 = ["INMARKETTIMINGS_S2_revised.csv", "INMARKETTIMINGS_S1_revised.csv"]
list2 = ["Market2", "Market1"]
i = 0
for file in list1:
    f = pd.read_csv(file)
    keep_col = ["coded_hh_id", "Date_number", "ESTIMATED_MIlEAGE", "PURCHASE_EVENT", "RO_EVENT", "RO_TOTAL_COST", "PTOTAL_2_OR_MORE", "PTOTAL_ASIAN", "PTOTAL_BLACK", "PTOTAL_HAWAIIAN"]
    new_f = f[keep_col]
    new_f.to_csv(list2[i], index=False)
    i += 1
