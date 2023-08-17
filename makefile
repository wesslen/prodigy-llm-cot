generate:
	dotenv run -- python -m prodigy terms.openai.fetch "Generate doctor's notes precribing drugs, dosages, form, duration, route, strength, and frequency." ./assets/health-generated.jsonl --n 65

ner-v2-fetch-1:
	dotenv run -- python -m prodigy ner.llm.fetch configs/config_01.cfg ./assets/health-generated.jsonl ./assets/annotated-01.jsonl

ner-v2-fetch-2:
	dotenv run -- python -m prodigy ner.llm.fetch configs/config_02.cfg ./assets/health-generated.jsonl ./assets/annotated-02.jsonl

ner-v2-fetch-3:
	dotenv run -- python -m prodigy ner.llm.fetch configs/config_03.cfg ./assets/health-generated.jsonl ./assets/annotated-03.jsonl
