import pandas as pd
from snakemake.utils import validate


validate(config, "../schemas/config.schema.yaml")

samples = (
    pd.read_csv(config["samplesheet"], sep=",", dtype={"sample_name": str})
    .set_index("sample_name", drop=False)
    .sort_index()
)

validate(samples, "../schemas/samples.schema.yaml")

SAMPLES = samples["sample_name"].tolist()
