class_name LogicEvaluator


static func evaluate(level_id: String, vars: Dictionary) -> bool:
	match level_id:
		"tutorial":
			return vars.get("A", false) and vars.get("B", false)
		"lvl1":
			return (vars.get("A", false) and vars.get("B", false)) or vars.get("C", false)
		"lvl2":
			return (vars.get("A", false) and vars.get("B", false)) or (vars.get("C", false) and vars.get("D", false))
		"lvl3":
			return (vars.get("A", false) or vars.get("B", false)) and not (vars.get("A", false) and vars.get("B", false))
		"lvl4":
			return (vars.get("A", false) and vars.get("B", false)) or (vars.get("C", false) and not vars.get("D", false))
		"lvl5":
			return vars.get("A", false) and (vars.get("B", false) or vars.get("C", false) or vars.get("D", false))
	return false


static func get_expression_text(level_id: String) -> String:
	match level_id:
		"tutorial": return "(A e B)"
		"lvl1":     return "((A e B) ou C)"
		"lvl2":     return "((A e B) ou (C e D))"
		"lvl3":     return "((A ou B) e ~(A e B))"
		"lvl4":     return "((A e B) ou (C e ~D))"
		"lvl5":     return "(A e (B ou C ou D))"
	return ""
