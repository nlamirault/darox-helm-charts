{{- define "chatbot-ui.createSecrets" -}}
{{- $name := include "chatbot-ui.name" . -}}
{{- range $secret := .Values.secrets }}
{{- $secret_name := index $secret "name" }}
{{- $env := index $secret "env" }}
{{- $Release := .Release -}}
{{- $string_data := dict }}
{{- range $e := $env }}
{{- $env_name := index $e "name" }}
{{- $env_value := index $e "value" }}
{{- if ne $env_value "" }}
{{- $string_data = merge $string_data (dict $env_name $env_value) }}
{{- end }}
{{- end }}
{{- if gt (len $string_data) 0 }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $name }}-{{ $secret_name }}
  labels:
    app.kubernetes.io/name: {{ $name }}
    app.kubernetes.io/instance: {{ $.Release.Name }}
type: Opaque
stringData:
  {{- range $key, $value := $string_data }}
  {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "chatbot-ui.labels" -}}
  app.kubernetes.io/name: {{ include "chatbot-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "chatbot-ui.name" -}}
chabot-ui
{{- end -}}

