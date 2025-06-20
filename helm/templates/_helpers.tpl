{{/*
Expand the name of the chart.
*/}}
{{- define "hellonode.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hellonode.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hellonode.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hellonode.labels" -}}
helm.sh/chart: {{ include "hellonode.chart" . }}
{{ include "hellonode.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hellonode.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hellonode.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "serviceAccount" -}}
{{- if .Values.serviceAccount.create -}}
    {{ .Values.serviceAccount.name | default (printf "%s-service-account" .Release.Name) }}
{{- else if not .Values.serviceAccount.create -}}
    {{ .Values.serviceAccount.name | default (printf "hellonode-sa") }}
{{- end }}
{{- end }}

{{/*
Create the name of the image pull secret to use
*/}}
{{- define "registrySecret" -}}
{{- if .Values.imageCredentials.create -}}
    {{ .Values.imageCredentials.name | default (printf "%s-registry-secret" .Release.Name) }}
{{- else if not .Values.imageCredentials.create -}}
    {{ .Values.imageCredentials.name | default (printf "hellonode-registry-secret") }}
{{- end }}
{{- end }}

{{/*
Create the nameregistry pull secret - not used due to complex escaping of GAR json
{{- define "imagePullSecret" -}}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" (required "A valid .Values.imageCredentials.registry entry required" .Values.imageCredentials.registry) (printf "%s:%s" (default "A valid .Values.imageCredentials.username entry" .Values.imageCredentials.username) (default "A valid .Values.imageCredentials.password entry" .Values.imageCredentials.password) | b64enc) | b64enc }}
{{- end }}
*/}}