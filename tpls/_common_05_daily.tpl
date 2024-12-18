{{- $today := .Body.Day -}}
{{- $events := .Cfg.Events -}}

\begin{minipage}[t]{\myLenTriCol}
{{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day}}
  \vspace{\dimexpr4mm+.3pt}

{{- if .Cfg.CalAfterSchedule -}}
{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
{{- end -}}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\myDummyQ}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr2mm
  \myUnderline{Notes $\vert$ {{ $today.LinkLeaf "More" "More" }}\hfill{}{{ $today.LinkLeaf "Reflect" "Reflect" }}\hfill{}\hyperlink{Notes Index}{All notes}}
  \myMash[\myDailySpring]{\myNumDailyNotes}{\myNumDotWidthTwoThirds}
  \vskip\dimexpr2mm

\myUnderline{Events}
\begin{itemize}
  {{- range $events }}
    {{- if eq (formatDate $today.Time) .FormattedDate }}
      \item {{.FormattedTime}} - {{ .Summary }}
    {{- end }}
  {{- end }}
\end{itemize}

\end{minipage}
\par\pagebreak
