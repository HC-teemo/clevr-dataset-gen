./generate_templates.sh
python generate_questions.py --no_program --num_scenes 100
rm -f ../output/questions_check.log
python query_grammer_check.py
