{{- /* Arquivo: trivy-markdown.tpl */ -}}
# Relatório de Vulnerabilidades - Trivy

{{- /* Verifica se existe algum conteúdo no relatório */ -}}
{{- if . }}
{{- /* O ponto (.) aqui já representa a lista de Resultados (types.Results) */ -}}
{{- range . }}

### Alvo: {{ .Target }}
{{- if (eq (len .Vulnerabilities) 0) }}
*Nenhuma vulnerabilidade encontrada.*
{{- else }}

| Pacote | ID (CVE) | Severidade | Versão Instalada | Correção em | Título |
| :--- | :--- | :--- | :--- | :--- | :--- |
{{- range .Vulnerabilities }}
| `{{ .PkgName }}` | [{{ .VulnerabilityID }}]({{ .PrimaryURL }}) | **{{ .Severity }}** | {{ .InstalledVersion }} | {{ .FixedVersion }} | {{ .Title }} |
{{- end }}
{{- end }}
{{- end }}
{{- else }}
Relatório vazio ou erro na leitura.
{{- end }}