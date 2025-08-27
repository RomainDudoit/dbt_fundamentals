{# 
Macro dbt par défaut : génère un nom de schéma pour chaque modèle.
- Si `custom_schema_name` est fourni, il est ajouté après le schema cible (`target.schema`), séparé par un "_".
- Sinon, le schéma par défaut (`target.schema`) est utilisé.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}

    {# Récupère le schéma par défaut défini dans profile.yml #}
    {%- set default_schema = target.schema -%}
    {%- set env = env_var('DBT_ENV_NAME') -%}


    {# Si aucun nom de schéma personnalisé n'est fourni, utiliser le schéma par défaut #}
    {%- if custom_schema_name is none or env =='dev' -%}
        {{ default_schema }}

    {# Sinon, concaténer le schéma par défaut et le nom personnalisé #}
    {%- else -%}

        {# Réécriture du comportement par défaut pour choisir le schéma spécifié dans dbt_project.yml 
        au lieu de faire la concaténation des schémas spécfiés dans profile.yml et dbt_project.yml #}
        {# {{ default_schema }}_{{ custom_schema_name | trim }} #}
        {{ custom_schema_name }}
    {%- endif -%}

{%- endmacro %}
