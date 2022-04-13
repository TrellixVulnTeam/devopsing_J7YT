import os

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta

args = {
    'owner': 'owner',
    'start_date': datetime(2021, 1, 11),
    'provide_context': True
}

def some_command(**kwargs):
    return "some python operator value"

with DAG('hello_world', description='Hello world', schedule_interval='*/1 * * * *', catchup=False, default_args=args) as dag:
    t1 = BashOperator(
        task_id='task1',
        bash_command='echo "Hello world from Task1"'
    )

    t2 = BashOperator(
        task_id='task2',
        bash_command='echo "Hello world from Task2"'
    )

    t3 = PythonOperator(
        task_id='task3',
        python_callable=some_command
    )

    t4 = BashOperator(
        task_id='task4',
        bash_command='echo "Hello world from Task4"'
    )

    t1 >> t2
    t1 >> t3
    t2 >> t4
    t3 >> t4