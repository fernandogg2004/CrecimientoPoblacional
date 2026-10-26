# Fish population under a pollutant — qualitative analysis of a nonlinear ODE system

Analytical study (equilibria, linearisation, Lyapunov stability) and MATLAB phase-portrait
simulation of a two-dimensional ODE model in which a pollutant discharged into a body of water
reduces a logistically growing fish population.

## The problem

A treatment-plant failure keeps discharging a pollutant into a lake. The pollutant decays
naturally and is partly absorbed by the fish, while it raises fish mortality. The question is
qualitative: **for which parameter regimes does the population go extinct, and for which does it
settle at a positive equilibrium?** Answering it requires locating the equilibria, classifying
their stability — including a non-hyperbolic case where linearisation is inconclusive — and
estimating basins of attraction.

## At a glance

| | |
|---|---|
| **Model** | `x' = r x (1 − x) − α x y`, `y' = I − d y − β x y`, with `x` = population / carrying capacity and `y` = pollutant concentration (all constants positive) |
| **Methods** | Nullclines and equilibria; Jacobian linearisation; a Lyapunov function for the critical case; phase portraits with `ode45` |
| **Main results** | The extinction equilibrium `E₀ = (0, I/d)` always exists; it is locally asymptotically stable when `r d < α I` and a saddle when `r d > α I`. In the critical case `r d = α I` (one zero eigenvalue) a Lyapunov function proves asymptotic stability and gives an estimate of the basin of attraction. Interior (coexistence) equilibria are analysed for example parameter sets |
| **Type** | University group coursework, Universidade de Santiago de Compostela, academic year 2024/25 (report dated December 2024) |

## Key result: the critical case

For the critical parameter set used in the report (`r = α = I = d = β = 1/2`, so `r d = α I`), the
Jacobian at `E₀ = (0, 1)` has eigenvalues `{0, −1/2}`, so linearisation does not decide stability.
The report constructs

```
V(x, y) = x² + (y − 1)²/2 + x (y − 1)
```

whose derivative along trajectories is

```
V̇(x, y) = −½ (2x + 1)(x + y − 1)²  ≤ 0   for x > −1/2,
```

and combines this with the geometry of the elliptical level sets of `V` to show asymptotic
stability of `E₀` and to approximate its basin of attraction.

*Verification:* both the eigenvalues and the closed form of `V̇` were re-derived symbolically with
SymPy for this README (2026-10-26) and match the report.

## Contents

| File | Description |
|---|---|
| [`Estudio_de_Poblaciones_influidas_por_un_Contaminante.pdf`](Estudio_de_Poblaciones_influidas_por_un_Contaminante.pdf) | 15-page report (Spanish): model derivation, equilibria, orbits, stability of `E₀` (linearisation and Lyapunov), other equilibria, conclusions |
| [`Orbitas.m`](Orbitas.m) | MATLAB script: vector field (`quiver`) and orbits from seven initial conditions integrated with `ode45` over `t ∈ [−100, 100]` |

## Running the simulation

Requires MATLAB (base installation; `ode45`, `meshgrid` and `quiver` are built in).

```matlab
Orbitas    % opens the phase portrait for the parameters set at the top of the file
```

The script was not executed for this README (no MATLAB licence in the review environment).

**Note on the plot markers.** The active parameters are `r = 0.5, α = 0.4, I = 0.4, d = 0.5,
β = 0.5`, for which the equilibria are `E₀ = (0, 0.8)` and an interior equilibrium at `(0.6, 0.5)`.
The script also marks the point `(0.2, 1)`, which is the interior equilibrium of the commented-out
parameter set with `d = 0.3`; edit the marker if you change parameters.

## Limitations

- Purely qualitative analysis: parameters are illustrative, not estimated from data.
- The Lyapunov argument is carried out for one critical parameter set, not in full generality.
- Interior equilibria are analysed for example parameter values rather than through a complete
  bifurcation analysis.
- Integrating backwards in time (`t < 0`) can leave the biologically meaningful region `x, y ≥ 0`;
  those parts of the orbits are shown for geometric context only.

## Technologies

Ordinary differential equations, linear stability analysis, Lyapunov methods, MATLAB, LaTeX.

## Authors

Report by María Sabucedo García, Iván Vázquez Cruces, Pedro Muñoz Polanco Contioso, Raquel Manzano
Núñez, **Fernando González González** and Manuel Zumel López (USC, 2024/25), as listed on the
report's title page.

Repository maintained by Fernando González González —
[LinkedIn](https://www.linkedin.com/in/fernando-gonzalez-gonzalez-math/) ·
[GitHub](https://github.com/fernandogg2004)
