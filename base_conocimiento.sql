CREATE OR REPLACE FUNCTION public.base_conocimiento (    
  query_embedding vector(768), 
  match_count int DEFAULT 5,
  filter jsonb DEFAULT '{}'
) RETURNS TABLE (
  id integer,                
  content text,              
  metadata jsonb,            
  similarity float
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.id,
    c.content,
    c.metadata,
    1 - (c.embedding <=> query_embedding) AS similarity
  FROM public.chunks c
  WHERE c.metadata @> filter
  ORDER BY c.embedding <=> query_embedding
  LIMIT match_count;
END;
$$;