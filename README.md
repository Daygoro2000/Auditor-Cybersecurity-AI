# AI Compliance and Security Auditor (RAG Architecture)

Este proyecto implementa un sistema avanzado de Inteligencia Artificial basado en la arquitectura RAG (Retrieval-Augmented Generation) diseñado para automatizar los procesos de auditoría de ciberseguridad y cumplimiento normativo.

El flujo principal del sistema permite la ingesta de un documento PDF que representa la política de seguridad interna de una organización. Este documento es procesado, fragmentado (chunking), vectorizado y almacenado en una base de datos vectorial. A partir de este punto, el sistema permite realizar consultas en lenguaje natural para evaluar y contrastar dicha política corporativa contra marcos normativos oficiales e internacionales previamente indexados en el sistema, específicamente: ISO 27001, GDPR y el Esquema Nacional de Seguridad (ENS).

## Capacidades Core y Casos de Uso

*   **Auditoría de Cumplimiento:** Análisis estructurado de las áreas cubiertas por la política de seguridad corporativa, referenciando las secciones exactas del documento original.
*   **Gap Analysis (Análisis de Brechas):** Detección automatizada de incumplimientos mediante el cruce de la información corporativa con los estándares normativos pre-cargados.
*   **Consultoría Técnica:** Resolución de preguntas específicas de auditoría basándose exclusivamente en el contexto documental proporcionado al modelo.
*   **Estrategia de Remediación:** Generación de propuestas de mejora priorizadas según su nivel de criticidad y el esfuerzo estimado para su implementación.

## Arquitectura y Stack Tecnológico

El proyecto está diseñado bajo una arquitectura modular que separa los flujos de ingesta de datos y la inferencia del modelo.

*   **Orquestación:** n8n desplegado en un entorno local (Docker) para gestionar las integraciones y los flujos de trabajo del agente de IA.
*   **Large Language Model (LLM):** Llama-3.1-8b-instant consumido a través de la API de Groq para garantizar una inferencia de muy baja latencia.
*   **Generación de Embeddings:** Ollama utilizando el modelo `nomic-embed-text` (768 dimensiones) ejecutado de forma local para asegurar la privacidad de los datos durante la vectorización.
*   **Base de Datos Vectorial:** Supabase con la extensión `pgvector` para el almacenamiento persistente de los fragmentos de texto y la ejecución de búsquedas por similitud del coseno.
*   **Gestión Documental:** Integración con la API de Google Drive para la extracción automatizada de los documentos PDF.

## Demostración del Sistema

A continuación se incluyen demostraciones en vídeo que ilustran el funcionamiento del sistema:
https://drive.google.com/drive/folders/1Em2Z4x52rhWkUcbaFcnfAWFQbfqqvTgj?usp=sharing
