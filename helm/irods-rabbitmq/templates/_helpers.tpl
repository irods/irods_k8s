{{/*BSD 3-Clause License All rights reserved.*/}}

{{/*SPDX-License-Identifier: BSD 3-Clause License*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "irods-rabbitmq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "irods-rabbitmq.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "irods-rabbitmq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "irods-rabbitmq.labels" -}}
helm.sh/chart: {{ include "irods-rabbitmq.chart" . }}
{{ include "irods-rabbitmq.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "irods-rabbitmq.selectorLabels" -}}
app.kubernetes.io/name: {{ include "irods-rabbitmq.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "irods-rabbitmq.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "irods-rabbitmq.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Service type
*/}}
{{- define "irods-rabbitmq.serviceDefinition" -}}
type: {{ .Values.service.type }}
{{- if eq .Values.service.type "LoadBalancer" }}
{{- if .Values.service.loadBalancerIP }}
loadBalancerIP: {{ .Values.service.loadBalancerIP }}
{{- end }}
{{- end }}
{{- end -}}
