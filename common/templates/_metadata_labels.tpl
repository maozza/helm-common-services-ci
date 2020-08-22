{{- define "common.metadata.labels" -}}
    app: {{ include "common.fullname" . }}
    owner: {{ .Values.company }}
    helm.sh/chart: {{ include "common.chartref" . }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
