package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

type Test struct {
	ent.Schema
}

func (Test) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Unique(),
	}
}

func (Test) Edges() []ent.Edge {
	return nil
}
