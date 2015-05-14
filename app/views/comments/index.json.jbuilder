json.array!(@comments) do |comment|
  json.extract! comment, :id, :comment, :author, :father_id, :page_id
  json.url comment_url(comment, format: :json)
end
