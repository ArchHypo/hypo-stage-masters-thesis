# Figures

Place thesis figures here. Supported formats: `.pdf`, `.png`, `.jpg`, `.svg`.

LaTeX will find them automatically via `\graphicspath` — no need to specify the directory in `\includegraphics`.

## Usage example

```latex
\begin{figure}[htb]
  \centering
  \includegraphics[width=0.8\textwidth]{arch-stage-screenshot}
  \caption{The Arch-Stage hypothesis management interface.}
  \label{fig:arch-stage-ui}
\end{figure}
```

## Subfigures example

```latex
\begin{figure}[htb]
  \centering
  \begin{subfigure}[b]{0.48\textwidth}
    \centering
    \includegraphics[width=\textwidth]{uncertainty-impact-before}
    \caption{Before refinement.}
    \label{fig:ui-before}
  \end{subfigure}
  \hfill
  \begin{subfigure}[b]{0.48\textwidth}
    \centering
    \includegraphics[width=\textwidth]{uncertainty-impact-after}
    \caption{After refinement.}
    \label{fig:ui-after}
  \end{subfigure}
  \caption{Uncertainty vs. impact visualization before and after tool refinement.}
  \label{fig:ui-comparison}
\end{figure}
```

## Naming convention

Use lowercase, hyphen-separated names that describe the content:
- `arch-stage-screenshot.png`
- `archhypo-overview-diagram.pdf`
- `hypothesis-lifecycle-chart.pdf`
- `team-survey-results.pdf`
