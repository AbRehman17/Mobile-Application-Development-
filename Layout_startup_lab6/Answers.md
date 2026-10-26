A1: 30
A2: 7
A3: 4
A4: 66

B1: Stateless: LabApp, HomePage, SettingsCard, Probe, SummaryRow, Welcome, InfoPanel, ShareRow, InfoBox, StampStack. They have no mutable local State. Stateful: Clock, Tile, SwapBoard. They maintain changing time, tap counts or tile order.
B2: New Widget configurations are created on rebuild; existing Elements and compatible State objects persist, while RenderObjects are generally reused and updated. Probe shows a changing Widget identity and stable Element identity.
B3: Parent constraints go down to children, and child sizes go up. In Step 7, Expanded constrains each Text to a third of the Row, causing wrapping instead of overflow.
