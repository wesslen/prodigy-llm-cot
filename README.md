## Setup

Setup `.env` file with per [instructions](https://prodi.gy/docs/large-language-models#env-important):

```
PRODIGY_OPENAI_KEY="sk-xxxxxxxxxxxxxxx"
PRODIGY_OPENAI_ORG="org-xxxxxxxxxxxxxx"
```

Create a new virtual environment:

```
python3.9 -m venv venv
source venv/bin/activate
```

Install Prodigy `v1.13` or higher given your `PRODIGY_KEY`:

```
pip install prodigy -f https://$PRODIGY_KEY@download.prodi.gy

Looking in links: https://****@download.prodi.gy
User for download.prodi.gy: [ENTER PRODIGY_KEY]
```

## Experiments:

### `config-01.cfg`: Zero shot 

To fetch, `make ner-v2-fetch-1` or

```
dotenv run -- python -m prodigy ner.llm.fetch configs/config_01.cfg ./assets/health-generated.jsonl ./assets/annotated-01.jsonl
```

To view in Prodigy:

```
python -m ner.manual ner-llm-
```

```
[nlp]
lang = "en"
pipeline = ["llm"]

[components]

[components.llm]
factory = "llm"

[components.llm.task]
@llm_tasks = "spacy.NER.v2"
labels = ["DOSAGE", "DRUG", "DURATION", "FORM", "FREQUENCY", "ROUTE", "STRENGTH"]

[components.llm.model]
@llm_models = "spacy.GPT-3-5.v1"
config = {"temperature": 0.3}
```

### `config-02.cfg`: Zero shot with label descriptions

```
[nlp]
lang = "en"
pipeline = ["llm"]

[components]

[components.llm]
factory = "llm"

[components.llm.task]
@llm_tasks = "spacy.NER.v2"
labels = ["DOSAGE", "DRUG", "DURATION", "FORM", "FREQUENCY", "ROUTE", "STRENGTH"]

[components.llm.task.label_definitions]
DOSAGE = "The total amount of a drug administered"
DRUG = "Generic or brand name of the medication"
DURATION = "The length of time that the drug was prescribed for"
FORM = "A particular configuration of the drug which it is marketed for use"
FREQUENCY = "The dosage regimen at which the medication should be administered"
ROUTE = "The path by which the drug is taken into the body"
STRENGTH = "The amount of drug in a given dosage"

[components.llm.model]
@llm_models = "spacy.GPT-3-5.v1"
config = {"temperature": 0.3}
```


### `config-03.cfg`: Few shot with label descriptions

```
[nlp]
lang = "en"
pipeline = ["llm"]

[components]

[components.llm]
factory = "llm"

[components.llm.task]
@llm_tasks = "spacy.NER.v2"
labels = ["DOSAGE", "DRUG", "DURATION", "FORM", "FREQUENCY", "ROUTE", "STRENGTH"]

[components.llm.task.label_definitions]
DOSAGE = "The total amount of a drug administered"
DRUG = "Generic or brand name of the medication"
DURATION = "The length of time that the drug was prescribed for"
FORM = "A particular configuration of the drug which it is marketed for use"
FREQUENCY = "The dosage regimen at which the medication should be administered"
ROUTE = "The path by which the drug is taken into the body"
STRENGTH = "The amount of drug in a given dosage"

[components.llm.model]
@llm_models = "spacy.GPT-3-5.v1"
config = {"temperature": 0.3}

[components.llm.task.examples]
@misc = "spacy.FewShotReader.v1"
path = "assets/few-shot-examples.yml"

[components.llm.cache]
@llm_misc = "spacy.BatchCache.v1"
path = "local-cached"
batch_size = 3
max_batches_in_mem = 10
```

And using `assets/few-shot-examples.yml`:

```
- text: "A patient was prescribed Magnesium hydroxide 400mg/5ml suspension PO of total 30ml bid for the next 5 days."
  entities:
    DRUG: ['Magnesium hydroxide']
    STRENGTH: ['400mg/5ml']
    FORM: ['suspension']
    ROUTE: ['PO']
    DOSAGE: ['30ml']
    FREQUENCY: ['bid']
    DURATION: ['for the next 5 days']

- text: "Prescribe aspirin 300mg tablet once a day p.o. (by mouth) for 3 days."
  entities:
    DRUG: ['aspirin']
    STRENGTH: ['300mg']
    FORM: ['tablet']
    ROUTE: ['p.o. (by mouth)']
    DOSAGE: ['300mg']
    FREQUENCY: ['once a day']
    DURATION: ['for 3 days']
```

### `config-04.cfg`: Chain-of-thought with v3

TODO
